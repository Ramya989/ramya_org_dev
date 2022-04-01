import { api, LightningElement, track } from 'lwc';
import getPersonsData from '@salesforce/apex/PersonsController.PersonsData';


export default class Persons extends LightningElement {
 @track personsList = [];
 @track  accountList = []; 
 @track selectAll = false;

 connectedCallback(){
    getPersonsData()
    .then(result => {        
        for (let item of result) {
            this.personsList.push({
                checkStatus : false,
                Name: item.Name,  
                Id:  item.Id      
            })
        }
    })
    .catch();
 }

 get showPills() {
    return this.accountList.length>0;
  }

 handleCheck(event) {   
    
   if(event.target.checked ){  
    this.accountList.push({
        name: event.target.value,      
        label: event.target.value       
    })
    console.log(event.target)
    console.log(event.target.getAttribute('data-id'))
   } else {
    let listndex = -1;
    for (let index = 0; index < this.accountList.length; index++) {
        if(this.accountList[index].name === event.target.value){
            listndex = index;
        }
    }
    if(listndex != -1){
        this.accountList.splice(listndex, 1);
    }    
   }
 }

  handleItemRemove(event) {    
    if (this.accountList[event.detail.index].name === event.detail.item.name)
      this.accountList.splice(event.detail.index, 1);
    
      for (let item of this.personsList) {       
        if(item.Name === event.detail.item.name){
            item.checkStatus = false;
        }
      }
 }

 handleSelectAll(event) { 
    for (let item of this.personsList) {
        item.checkStatus =  event.target.checked;
        if(event.target.checked){
            this.accountList.push({
                name: item.Name,      
                label:  item.Name
            })   
        }
    }
    if(this.accountList.length > 0 && !event.target.checked ){
        this.accountList = []; 
    }
 }

}