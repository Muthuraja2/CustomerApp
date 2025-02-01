CLASS zcl_order_data_upload DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_order_data_upload IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    MODIFY ENTITIES OF zr_customer_data
        ENTITY Customer
        CREATE AUTO FILL CID
        WITH VALUE #( ( Name = 'Customer 1' %control-Name = if_abap_behv=>mk-on ) )
        MAPPED DATA(ls_mapped)
        REPORTED DATA(ls_reported)
        FAILED DATA(ls_failed).

    IF ls_mapped-customer IS NOT INITIAL.

      out->write( ls_mapped-customer[ 1 ]-CustomerUuid ).

      COMMIT ENTITIES RESPONSE OF zr_customer_data
          FAILED DATA(ls_commit_failed)
          REPORTED DATA(ls_commit_reported).

       if ls_commit_failed is INITIAL and ls_commit_reported is initial.
        out->write( 'data got inserted' ).
       endif.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
