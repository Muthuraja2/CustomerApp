@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Restrc. Reuse view - Customer'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_CUSTOMER_DATA
  as select from ZI_CUSTOMER_DATA
{
  key CustomerUuid,
      Name,
      City,
      Country,
      Email,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.user.lastChangedBy: true
      LastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      ChangedAt
}
