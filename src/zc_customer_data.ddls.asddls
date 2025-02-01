@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View - Customer data'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_CUSTOMER_DATA
  provider contract transactional_query
  as projection on ZR_CUSTOMER_DATA
{
  key CustomerUuid,
      Name,
      City,
      Country,
      Email,
      CreatedBy,
      LastChangedBy,
      CreatedAt,
      ChangedAt 
}
