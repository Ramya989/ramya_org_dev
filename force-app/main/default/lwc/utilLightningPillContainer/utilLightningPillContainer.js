import { LightningElement,api } from 'lwc';

export default class UtilLightningPillCcontainer extends LightningElement {
    @api getPersonsList;
    @api handlePill;
    @api pillCount; 


    @api showPillsCount() {
        return  this.getPersonsList.length;
    }

    get showPills() {
        return this.getPersonsList.length > 0;
    }

}
