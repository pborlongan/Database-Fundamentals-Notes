# Normalization

##  3NF

Order (<b class="pk">OrderNumber</b>, <u class ="fk">CustomerNumber</u>, Date, Subtotal, GST, Total )

OrderDetail (<b class="pk"><u class="fk">OrderNumber,</u> <u class="fk">ItemNumber</u></b>, Quantity, SellingPrice, Amount)
    
Item (<b class="pk">ItemNumber</b>, Description, CurrentPrice)

Customer (<b class="pk">CustomerNumber</b>, FirstName, LastName, Address, City, Province, PostalCode, Phone)

## Tables

### *Order Table*

| <b class="pk">OrderNumber</b>        | <u class="fk">CustomerNumber<u>        |   Date  | Subtotal | GST | Total
| ------------- |:-------------:| -----:|-----: |-----: |-----: | 
|    219   | 137 | Jan. 16, 2000 | 24.29 | 1.70 | 25.99 |


### *Order Detail*
| <b class="pk">OrderNumber</b>       | <b class="pk">ItemNumber</b>     | Quantity  | SellingPrice | Amount |
| ------------- |:-------------:| -----:|-----: |-----: |
|219|H23|1|11.99|11.99|
|219|H319|2|4.99|9.98|
|219|M24|8|0.29|2.32|

**note**: the ordernumber and itemnumber are considered as a composite key

### *Item Table*
| `ItemNumber`       | Description           | CurrentPrice  | 
| ------------- |:-------------:| -----:|
|H23|Heater Fan Belt - 2"|11.99|
|H319|Heater Fan Belt Support Brackets|4.99|
|H23|Bolts - 24 mm|0.29|

### *Customer Table*
| `CustomerNumber`       | FirstName           | LastName  |   Address       | City           | Province  |  PostalCode       | Phone           | 
| ------------- |:-------------:| -----:| ------------- |:-------------:| -----:| ------------- |:-------------:|
| 137 |Fred | Smith| 123 SomeWhere St. | Edmonton | AB | T5H 2J9 | 436-7867


## Translation

Each **Customer** must be <u>one who places</u> one or more **Orders**.

Each **Order** must be <u>placed by</u> one and only one **Customer**.

Each **Order** must be <u>made up of</u> one or more **OrderDetails**.

Each **OrderDetail** must be <u>for</u> one and only one **Order**.

Each **Item** may be <u>sold under</u> one or more **OrderDetails**.

Each **OrderDetail** must be <u>a sale of</u> one and only one **Item**.


<style type="text/css">
.pk {
    font-weight: bold;
    display: inline-block;
    border: solid thin blue;
    padding: 0 1px;
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