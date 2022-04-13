import { LightningElement,api,track } from 'lwc';

export default class EditPersons extends LightningElement {

    @track openModal = false;
    @api getPersonsList;
    @track recordList = [];

    renderedcallback(){
        for (let item of this.getPersonsList) {
            this.recordList.push({
                name:  item.name,   
                label: item.label
            }) 
        }
        console.log(this.recordList);   
    }

    showModal() {
        this.openModal = true;
        return this.openModal;
    }

    closeModal() {
        console.log(this.recordList);
        this.openModal = false;
    }

    saveModal(){
        //console.log(this.getPersonsList.length);
    }

    get isEdit () {

       
        console.log(this.recordList.length);
        return  this.getPersonsList.length > 0;
     }
    

}