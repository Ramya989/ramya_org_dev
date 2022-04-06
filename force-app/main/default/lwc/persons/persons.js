import { api, LightningElement, track } from 'lwc';
import getPersonsData from '@salesforce/apex/PersonsController.PersonsData';


export default class Persons extends LightningElement {
 @track personsList = [];
 @track accountList = []; 
 @track selectAll = false;
 @track showPills = 0;

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

 get pillCounts () {
    let count = this.template.querySelector('c-util-Lightning-Pill-Container');     
    return  count!=null ? count.showPillsCount() : 0;
 }

 handleCheck(event) {   
    
   if(event.target.checked ){  
        this.accountList.push({
            name: event.target.value,      
            label: event.target.value       
        })
        for (let item of this.personsList) {            
            if(item.Name == event.target.value){
                item.checkStatus =  true;
            }
        }
   } else {
      for (let index = 0; index < this.accountList.length; index++) {
          if(this.accountList[index].name === event.target.value){
            this.accountList.splice(index, 1);
          }
      }
      if(this.accountList.length === 0) this.selectAll = false;        
   }
  
 }

  handleItemRemove = (event) => {
    if (this.accountList[event.detail.index].name === event.detail.item.name)
      this.accountList.splice(event.detail.index, 1);
     for (let index = 0; index < this.personsList.length; index++) {     
        if(this.personsList[index].Name === event.detail.item.name){            
            this.personsList[index].checkStatus = false;
        }
    }
 }

 handleSelectAll(event) { 
   this.accountList = [];
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