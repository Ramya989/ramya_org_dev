import { api, LightningElement, track } from 'lwc';
import getPersonsData from '@salesforce/apex/PersonsController.PersonsData';


export default class Persons extends LightningElement {
 allData = [];
 @track accountList = []; 
 @track selectAll;
 @track showPills = 0;
 @track isFilter = false;
 @track recordList = [];
 @track isEditModal = false;
 searchKey = null;
 

 connectedCallback(){
    getPersonsData()
    .then(result => { 
        for (let item of result) {
            this.allData.push({
                checkStatus : false,
                Name: item.Name,
                Id:  item.Id 
            })
        }
        this.recordList = this.allData;
    })
    .catch();
 }

 get pillCounts () {
    let count = this.template.querySelector('c-util-Lightning-Pill-Container');     
    return  count!=null ? count.showPillsCount() : 0;
 }

 get isSearch () {
    return  this.searchKey != null;
 }

 handleCheck(event) {   
    
   if(event.target.checked ){  
        this.accountList.push({
            name: event.target.dataset.id,      
            label: event.target.value
        })        
   } else {
      for (let index = 0; index < this.accountList.length; index++) {
          if(this.accountList[index].label === event.target.value){
            this.accountList.splice(index, 1);
          }
      }
   }
   this.handleSelect();
   this.updateCheck(event);
 }

 updateCheck(event){
    for (let item of this.allData) {            
        if(item.Name == event.target.value){
            item.checkStatus =  event.target.checked;
        }
    }
    if(this.searchKey == null)
    this.recordList = this.allData;
 }

 handleSelect(){
    if(this.accountList.length !== this.allData.length){
        this.selectAll = false;
    }
    if(this.accountList.length > 0 && (this.accountList.length === this.allData.length)){
        this.selectAll = true;
    } 
 }

  handleItemRemove = (event) => {
    if (this.accountList[event.detail.index].name === event.detail.item.name)
      this.accountList.splice(event.detail.index, 1);
     for (let index = 0; index < this.allData.length; index++) {     
        if(this.allData[index].Name === event.detail.item.name)            
            this.allData[index].checkStatus = false;
    }
    this.recordList = this.allData;
    this.handleSelect();
 }

 handleSelectAll(event) { 
   this.accountList = [];
   this.selectAll = event.target.checked;
    for (let item of this.allData) {
        item.checkStatus =  event.target.checked;
        if(event.target.checked){
            this.accountList.push({
                name: item.Name,
                label:  item.Name
            })
        }
    }
    if(this.accountList.length > 0 && !event.target.checked )
        this.accountList = [];
    this.recordList = this.allData;
 }
 
 addTableFilter() { 
    this.isFilter = !this.isFilter;
    if(this.isFilter==false)
    this.recordList = this.allData;
 }

 handleTableSearch(event) {
    this.searchKey = event.target.value == '' ? null : event.target.value;
    this.recordList = this.allData.filter( data => data.Name.toLowerCase().indexOf(event.target.value.toLowerCase()) > -1);
    this.handleSelect(); 
 }
}