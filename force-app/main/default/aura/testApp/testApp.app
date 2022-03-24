<aura:application extends='force:slds'>
    <aura:attribute name="aa" type="Integer" default="2"/>
    <aura:attribute name="bb" type="Integer" default="1"/>
    <aura:attribute type="Boolean" name="displayReadOnly" default="false"/>  
    
    <aura:attribute name="accountSubDispositionValue" type="String" default=""/>
    <aura:attribute name="BHapprovalToggle" type="Boolean"/> 
    <aura:attribute name="accountSubDispositionValues" type="String[]"/>
    <aura:attribute name="BHApprovalStatus" type="boolean"/> 
    <div class="slds-grid slds-wrap">
        <div class="slds-size_1-of-3" style = "padding-top: 25px;">
            <lightning:input type="toggle" label="BH approval - Exception cases" checked="{!v.BHapprovalToggle}" name="BHapproval"  aura:id="BHapprovalId"   messageToggleActive="Done"
                             messageToggleInactive="Not Done" onchange="{!c.getToggleValueForBHApproval}"/> 
        </div>
        <aura:if isTrue="{!v.BHApprovalStatus == true}">  
            <div class="slds-size_1-of-3">         
            <lightning:select aura:id="accountSubDispositionType" label="Sub Disposition BH Approval" value="{!v.accountSubDispositionValue}" messageWhenValueMissing="Please Select Value">
                <option value="">choose one...</option>
                <option value="New">New</option>
                <option value="In Progress">In-Progress</option>
                <option value="Resolved">Resolved</option>
                <option value="Closed">Closed</option>
            </lightning:select>
            </div>
        </aura:if> 
         <lightning:button   variant="brand" label="Generate Checklist" class="slds-align_absolute-center slds-theme--alt-inverse" 
                              iconName="action:update_status" iconPosition="left" onclick="{!c.getChecklistDoc}" disabled="{!v.displayReadOnly}"/>
    </div>
</aura:application>