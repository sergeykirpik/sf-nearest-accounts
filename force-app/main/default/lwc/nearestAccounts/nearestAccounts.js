import { LightningElement } from 'lwc';
import getNearestAccounts from '@salesforce/apex/NearestAccountsController.getNearestAccounts';

const DEFAULT_ZOOM_LEVEL = 17;

export default class NearestAccounts extends LightningElement {

    accounts = [];
    currentLocation;
    zoomLevel = DEFAULT_ZOOM_LEVEL;

    get mapMarkers() {
        return [
            {
                 ...this.currentLocation,
                 title: 'Your Location',
            },
            ...this.accounts.map(acc => ({
                location: {
                    Latitude: acc.GPS__c.latitude,
                    Longitude: acc.GPS__c.longitude,
                },
                title: acc.Name,
        }))];
    }

    async getCurrentLocation() {
        return new Promise((resolve, reject) => {
            navigator.geolocation.getCurrentPosition(position => {
                const { latitude: Latitude, longitude: Longitude } = position.coords;
                this.currentLocation = {
                    location: { Latitude, Longitude }
                };
                resolve();
            }, reject);
        });
    }

    async getNearestAccounts() {
        const { Latitude, Longitude } = this.currentLocation.location;
        const accounts = await getNearestAccounts({
            latitude: Latitude,
            longitude: Longitude,
        });
        this.accounts = accounts.filter(acc => acc.GPS__c !== undefined);
    }

    async handleCurrentLocationClick() {
        try {
            await this.getCurrentLocation();
            this.getNearestAccounts();
        } catch (error) {
            this.handleError(error);
        }
    }

    handleError(error) {
        console.error(error);
    }
}
