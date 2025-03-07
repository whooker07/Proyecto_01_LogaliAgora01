CLASS zcl_wo_validator_agora01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      validate_create_order IMPORTING iv_customer_id   TYPE string
                                      iv_technician_id TYPE string
                                      iv_priority      TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,
      validate_update_order IMPORTING iv_work_order_id TYPE string
                                      iv_status        TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,
      validate_delete_order IMPORTING iv_work_order_id TYPE string
                                      iv_status        TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,
      validate_status_and_priority IMPORTING iv_status       TYPE string
                                             iv_priority     TYPE string
                                   RETURNING VALUE(rv_valid) TYPE abap_bool.
  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS:
      check_customer_exists IMPORTING iv_customer_id   TYPE string
                            RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_technician_exists IMPORTING iv_technician_id TYPE string
                              RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_order_exists IMPORTING iv_work_order_id TYPE string
                         RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_order_history IMPORTING iv_work_order_id TYPE string
                          RETURNING VALUE(rv_exists) TYPE abap_bool.

* NO ME FUNCIONARON ESTAS CONSTANTES, AL VALIDAR DECIA QUE NO ERAN TABLAS INTERNAS, lo hice con tabla interna en metodo
*    CONSTANTS: c_valid_status   TYPE string VALUE 'PE CO', " Example statuses: Pending, Completed
*               c_valid_priority TYPE string VALUE 'A B'. " Example priorities: High, Low



ENDCLASS.



CLASS zcl_wo_validator_agora01 IMPLEMENTATION.
  METHOD validate_create_order.

    " Declare a local internal table for valid priorities
    DATA: lt_valid_priority TYPE TABLE OF c WITH EMPTY KEY.


    " Initialize valid priorities (can be added dynamically if needed)
    lt_valid_priority = VALUE #( ( 'A' ) ( 'B' ) ). " Example priorities: High, Low



    " Check if customer exists
    DATA(lv_customer_exists) = check_customer_exists( iv_customer_id ).
    IF lv_customer_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    " Check if technician exists
    DATA(lv_technician_exists) = check_technician_exists( iv_technician_id ).
    IF lv_technician_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

*    " Check if priority is valid
*    IF iv_priority NOT IN c_valid_priority.
*      rv_valid = abap_false.
*      RETURN.
*    ENDIF.

    " Check if priority is valid (check against the internal table lt_valid_priority)

    LOOP AT lt_valid_priority INTO DATA(lv_valid_priority).
      IF iv_priority = lv_valid_priority.
        rv_valid = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.


    " If we reached here, priority is not valid
    rv_valid = abap_false.

*    rv_valid = abap_true.

  ENDMETHOD.

  METHOD validate_update_order.

    " Declare a local internal table for valid status
    DATA: lt_valid_status TYPE TABLE OF string WITH EMPTY KEY.

    " Inicializar los valores de la tabla interna con longitud fija de 2 caracteres
*    lt_valid_status = VALUE #( ( 'PE' ) ( 'CO' ) ).  " Valores 'PE' y 'CO' en la tabla interna     - no me funcionó

    APPEND 'PE' TO lt_valid_status.
    APPEND 'CO' TO lt_valid_status.

    " Check if the work order exists
    DATA(lv_order_exists) = check_order_exists( iv_work_order_id ).
    IF lv_order_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

*    " Check if the order status is editable (e.g., Pending)
*    IF iv_status NOT IN c_valid_status.
*      rv_valid = abap_false.
*      RETURN.
*    ENDIF.


    LOOP AT lt_valid_status INTO DATA(lv_valid_status).
      IF iv_status = lv_valid_status.
        rv_valid = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.


    " If we reached here, status is not valid
    rv_valid = abap_false.

*    rv_valid = abap_true.

  ENDMETHOD.

  METHOD validate_delete_order.

    " Check if the order exists
    DATA(lv_order_exists) = check_order_exists( iv_work_order_id ).
    IF lv_order_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    " Check if the order status is "PE" (Pending)
    IF iv_status NE 'PE'.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    "Check if the order has a history (i.e., if it has been modified before)
    DATA(lv_has_history) = check_order_history( iv_work_order_id ).
    IF lv_has_history IS NOT INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    rv_valid = abap_true.

  ENDMETHOD.

  METHOD validate_status_and_priority.

*    " Validate the status value
*    IF iv_status NOT IN c_valid_status.
*      rv_valid = abap_false.
*      RETURN.
*    ENDIF.

*    LOOP AT lt_valid_status INTO DATA(lv_valid_status).
*      IF iv_status = lv_valid_status.
*        rv_valid = abap_true.
*        RETURN.
*      ENDIF.
*    ENDLOOP.

*    " Validate the priority value
*    IF iv_priority NOT IN c_valid_priority.
*      rv_valid = abap_false.
*      RETURN.
*    ENDIF.
*
*    rv_valid = abap_true.

*    LOOP AT lt_valid_priority INTO DATA(lv_valid_priority).
*      IF iv_priority = lv_valid_priority.
*        rv_valid = abap_true.
*        RETURN.
*      ENDIF.
*    ENDLOOP.
*
*
*    " If we reached here, priority is not valid
*    rv_valid = abap_false.

  ENDMETHOD.




  METHOD check_customer_exists.

  ENDMETHOD.

  METHOD check_order_exists.

  ENDMETHOD.

  METHOD check_order_history.

  ENDMETHOD.

  METHOD check_technician_exists.

  ENDMETHOD.

ENDCLASS.
