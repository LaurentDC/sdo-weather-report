/**
 * @author Laurent Dibo-Cohen
 * @description Weather Report Component
 * @created 2024-01-31
 * @version 1.0.0
 * @todo : Handle labels translations / clean logs
 */

import { LightningElement, track, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi'
import { getWeatherLabels } from './lDC_WeatherDataService';
import getWeatherResponse from '@salesforce/apex/LDC_WeatherServiceController.getWeatherResponse';
import saveWeatherReport from '@salesforce/apex/LDC_WeatherServiceController.saveWeatherReport';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LDC_NewWeatherReportComponent extends LightningElement {
    constructor(){
        super();
        this.getLabels();
        console.log('labels : ', this.labels);
        console.log('LDC_NewWeatherReportComponent constructor');
    }

    @track isBtnDisabled = false;
    @track weatherData = [];
    @track _recordId;
    @track record;
    @track objectType;
    @track isLoading = true;
    @track rendered = false;
    @track error;
    @track labels;
    @track parameterValue;
    @track status;

    @api
    get recordId() {
        return this._recordId;
    }
    set recordId(value) {
        this._recordId = value;
        console.log('Record Id : ', value);
    }
    
    @wire(getRecord, { recordId: '$recordId', fields: ['Name'] })
    record({ data, error }) {
        if (data) {
            this.recordId = data.id;
            this.record = data;
            this.objectType = data.apiName;
            console.log('LDC record in wire: ', data.id);
            this.error = undefined;
       } else if (error) {
            console.log('LDC Record Error in wire: ', error);
            this.error = error;
            this.objectType = undefined;
            this.record = undefined;
     }
    }
    renderedCallback(){
    
        console.log('LDC_NewWeatherReportComponent Rendered');
        if(!this.rendered){
            setTimeout(() => {
                console.log('LDC objectType in renderedCallback: ', this.objectType);
                if (!this.objectType) {
                    this.getCurrentUserGeoLocation();
                } else {
                    this.parameterValue = this.recordId;
                    this.getWeatherData();
                }
            }, 3000);
        }
        this.rendered = true;
    }
    getCurrentUserGeoLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(position => {
                console.log('LDC_NewWeatherReportComponent getCurrentUserGeoLocation : ', position);
                //this.getWeatherResponse(position.coords.latitude, position.coords.longitude);
                this.objectType = 'User';
                this.parameterValue = position.coords.latitude + ',' + position.coords.longitude;
                this.getWeatherData();
            });
        } else {
            this.error = 'Geolocation is not supported by this browser.';
        }
    }

    getWeatherData() {
        getWeatherResponse({objectType: this.objectType, parameterValue: this.parameterValue})
           .then(result => {
                this.weatherData = result;
                console.log('User Response : ', result);
            })
           .catch(error => {
                console.log('Error getWeatherResponse : ', error);
                this.error = error.body.message;
            });
            this.isLoading = false;
    }
    getLabels(){
        this.labels = getWeatherLabels();
    }
    handleClick(event) {
        var wrapper = {
            temperature: this.weatherData.temperature? parseInt(this.weatherData.temperature) : null,
            humidity: this.weatherData.humidity? parseInt(this.weatherData.humidity) : 0,
            windSpeed: this.weatherData.windSpeed? parseInt(this.weatherData.windSpeed) : 0,
            weatherConditionLabel: this.weatherData.weatherConditionLabel? this.weatherData.weatherConditionLabel : null,
            weatherConditionKey: this.weatherData.weatherConditionKey? this.weatherData.weatherConditionKey : null,
            recordId: this.recordId? this.recordId : null,
            recordType: this.objectType? this.objectType : null,
            latitude: (this.objectType === 'User' && this.parameterValue != null) ? parseFloat(this.parameterValue.split(',')[0]) : null,
            longitude: (this.objectType === 'User' && this.parameterValue != null) ? parseFloat(this.parameterValue.split(',')[1]) : null
        }
        console.log('LDC_NewWeatherReportComponent handleClick payload to send : ');
        console.log(JSON.stringify(wrapper));
        saveWeatherReport({weatherReport: wrapper})
            .then(result => {
                this.status = result;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Weather Report sent successfully',
                        variant:'success',
                        mode: 'dismissable'
                    }));
            })
            .catch(error => {
                this.error = error.body.message;
                this.status = 'Error';
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Error sending Weather Report',
                        variant:'error',
                        mode: 'dismissable'
                    }));
            })
        this.isBtnDisabled = true;
    }
}