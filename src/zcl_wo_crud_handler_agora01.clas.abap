CLASS zcl_wo_crud_handler_agora01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      create_work_order IMPORTING iv_work_order_id TYPE zde_workorderid_agora01
                                  iv_customer_id   TYPE string
                                  iv_technician_id TYPE string
                                  iv_priority      TYPE string
                                  iv_status        TYPE string
                                  iv_description   TYPE string
                                  iv_creation_date TYPE d
                        EXPORTING rv_valid         TYPE abap_bool
                                  rv_message       TYPE string,

      read_work_order IMPORTING iv_work_order_id TYPE zde_workorderid_agora01

                      EXPORTING rv_valid         TYPE abap_bool
                                rv_message       TYPE string
                                rv_ls_work_order TYPE ztwork_order.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_wo_crud_handler_agora01 IMPLEMENTATION.
  METHOD create_work_order.

    DATA: ls_workorder TYPE ztwork_order.

    DATA(lo_instance) = NEW zcl_wo_validator_agora01( ).

    " Llamar al método de instancia

    IF lo_instance->validate_create_order( iv_customer_id   = iv_customer_id
                                           iv_technician_id = iv_technician_id
                                           iv_priority      = iv_priority ) = abap_false.

      rv_message =  | Data validation of creating work order not valid, please check |  .
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    ls_workorder = VALUE #( work_order_id = iv_work_order_id
                            customer_id   = iv_customer_id
                            technician_id = iv_technician_id
                            priority      = iv_priority
                            status        = iv_status
                            description   = iv_description
                            creation_date = iv_creation_date ).
    TRY.
        INSERT ztwork_order FROM @ls_workorder.
      CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
        rv_message =  | Work order { iv_work_order_id } was not inserted correctly : { lx_sql_db->get_text(  ) }|  .
        rv_valid = abap_false.
        RETURN.
    ENDTRY.

    IF sy-subrc = 0.
      rv_message =  | Work order { iv_work_order_id } inserted correctly|  .
      rv_valid = abap_true.
    ELSE.
      rv_message =  | Work order { iv_work_order_id } was not inserted correctly in table|  .
      rv_valid = abap_false.
    ENDIF.




  ENDMETHOD.

  METHOD read_work_order.
    SELECT SINGLE FROM ztwork_order
    FIELDS *
    WHERE work_order_id = @iv_work_order_id
    INTO @rv_ls_work_order.

    IF sy-subrc = 0.
      rv_message =  | Work order { iv_work_order_id } exitss|  .
      rv_valid = abap_true.

    ELSE.
      rv_message =  | Work order { iv_work_order_id } Not exists |  .
      rv_valid = abap_false.
    ENDIF.


  ENDMETHOD.

ENDCLASS.
