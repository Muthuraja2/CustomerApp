@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer - Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.dataCategory: #VALUE_HELP
define view entity ZC_CUSTOMER_VH
  as select from ZI_CUSTOMER_VH
{
      @UI.hidden: true
  key CustomerUuid,
      Name,
      Country
}
