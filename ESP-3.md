# ESP#3

## Inventory Control

### 0NF

**InventoryControlSheet**: ( <b class="pk">ItemNumber</b>, ItemDesciption, CurrentSalePrice, <b class="gr">{</b> Date, SuppplierNumber, PONumber, Quantity, Cost <b class="gr">}</b> ) 

### 1NF

After performing First Normal Form, a new single entity was generated: **OrderHistory**

**InventoryControlSheet**: ( <b class="pk">ItemNumber</b>, ItemDescription, CurrentSalePrice )

**OrderHistory**: (<b class="pk"><u class="fk">ItemNumber</u>, PONumber</b>, Date, Quantity, Cost, SupplierNumber)

## Inventory Control - After Normalization:

**InventoryControlSheet**: ( <b class="pk">ItemNumber</b>, ItemDescription, CurrentSalePrice )

**OrderHistory**: (<b class="pk"><u class="fk">ItemNumber</u>, PONumber</b>, Date, Quantity, Cost, SupplierNumber)


## Purchase Orders

### 0NF

**PurchaseOrder**: ( <b class="pk">PurchaseOrderNumber</b>, SupplierName, SupplierNumber, Address, City, PostalCode, Province, Phone, Date, <b class="gr">{</b> ItemNumber, SupplierItemNumber, SupplierDescription, Quantity, Cost, Amount, <b class="gr">}</b> Subtotal, GST, Total )

### 1NF

After performing First Normal Form, a new single entity was generated: **PurchaseOrderItem**

**PurchaseOrder**: ( <b class="pk">PurchaseOrderNumber</b>, SupplierName, SupplierNumber, Address, City, PostalCode, Province, Phone, Date, Subtotal, GST, Total )

**PurchaseOrderItem**: ( <b class="pk"><u class ="fk">PurchaseOrderNumber</u>, ItemNumber</b>, SupplierItemNumber, SupplierDescription, Quantity, Cost, Amount )

### 2NF

There is no partial dependency.

### 3NF 

After performing Third Normal Form, a two entities were generated:
**Supplier**, **SupplierItems**


**Supplier**: ( <b class="pk">SupplierNumber</b>, SupplierName, Address, City, Province, PostalCode)

**SupplierItems**: ( <b class="pk">SupplierItemNumber</b>, SupplierDescription, Cost )

## Purchase Order - After Normalization:

**PurchaseOrder**: ( <b class="pk">PurchaseOrderNumber</b>, <u class="fk">SupplierNumber</u>, Date, Subtotal, GST, Total )

**PurchaseOrderItem**: ( <b class="pk"><u class ="fk">PurchaseOrderNumber</u>, ItemNumber</b>, <u class ="fk">SupplierItemNumber</u>\, Quantity, Amount )

**Supplier**: ( <b class="pk">SupplierNumber</b>, SupplierName, Address, City, Province, PostalCode)

**SupplierItems**: ( <b class="pk">SupplierItemNumber</b>, SupplierDescription, Cost )


<style type="text/css">
.pk {
    font-weight: bold;
    display: inline-block;
    border: solid thin blue;
    padding: 0 1px;
}

.tk{
    color: orange;
    font-weight: bold;
}

.fk {
    color: green;
    font-style: italic;
    text-decoration: wavy underline green;    
}
.gr {
    color: darkorange;
    font-size: 1.2em;
    font-weight: bold;
}
</style>