import { LightningElement,api } from 'lwc';

export default class UtilLightningPillCcontainer extends LightningElement {
    @api getPersonsList;
    @api handlePill;

}
