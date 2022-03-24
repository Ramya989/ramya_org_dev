import { LightningElement,track,api } from 'lwc';
import getAccountDetails from '@salesforce/apex/customvftolwcController.getAccountDetails';

export default class Customvftolwc extends LightningElement {
   
    @track openModal = false;
   
    @api recordId;

    connectedCallback(){  debugger;
        getAccountDetails(({accId: this.recordId}))
        .then(result => {
            alert('sssssssssssssssssss=========='+(result)); 
        })
        .catch();
        
    }

    showModal() {
        this.openModal = true;
    }
    closeModal() {
        this.openModal = false;
    }
}