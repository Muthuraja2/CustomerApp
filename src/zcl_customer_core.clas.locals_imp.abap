CLASS lhc_Customer DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Customer RESULT result.
    METHODS valcreate FOR VALIDATE ON SAVE
      IMPORTING keys FOR customer~valcreate.

ENDCLASS.

CLASS lhc_Customer IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD valCreate.

    DATA: go_regex   TYPE REF TO cl_abap_regex,
          go_matcher TYPE REF TO cl_abap_matcher,
          go_match   TYPE c LENGTH 1,
          gv_msg     TYPE string.

    READ ENTITIES OF zr_customer_data IN LOCAL MODE
        ENTITY Customer
        FIELDS ( Name Country Email )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_result)
        REPORTED DATA(ls_reported)
        FAILED DATA(ls_failed).

    IF ls_reported-customer IS NOT INITIAL OR ls_failed-customer IS NOT INITIAL.
      reported = CORRESPONDING #( DEEP ls_reported ).
      failed = CORRESPONDING #( DEEP ls_failed ).
    ELSE.
      LOOP AT lt_result INTO DATA(result_row).
        IF result_row-Name IS INITIAL.
          failed-customer = VALUE #( BASE failed-customer ( %tky = result_row-%tky ) ).
          reported-customer = VALUE #( BASE reported-customer
                                        ( %tky = result_row-%tky
                                          %msg = new_message_with_text( text = 'Name is missing' ) ) ).
        ENDIF.
        IF result_row-Country IS INITIAL.
          failed-customer = VALUE #( BASE failed-customer ( %tky = result_row-%tky ) ).
          reported-customer = VALUE #( BASE reported-customer
                                        ( %tky = result_row-%tky
                                          %msg = new_message_with_text( text = 'Country is missing' ) ) ).
        ENDIF.
        IF result_row-Email IS INITIAL.
          failed-customer = VALUE #( BASE failed-customer ( %tky = result_row-%tky ) ).
          reported-customer = VALUE #( BASE reported-customer
                                        ( %tky = result_row-%tky
                                          %msg = new_message_with_text( text = 'Email is missing' ) ) ).
        ELSE.
          CREATE OBJECT go_regex
            EXPORTING
              pattern     = '\w+(\.\w+)*@(\w+\.)+(\w{2,4})'
              ignore_case = abap_true.

          go_matcher = go_regex->create_matcher( text = result_row-Email ).

          IF go_matcher->match( ) IS INITIAL.
            failed-customer = VALUE #( BASE failed-customer ( %tky = result_row-%tky ) ).
            reported-customer = VALUE #( BASE reported-customer
                                          ( %tky = result_row-%tky
                                            %msg = new_message_with_text( text = 'Email is not valid' ) ) ).
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
