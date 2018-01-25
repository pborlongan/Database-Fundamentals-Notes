# Normalization: Payments Log

## 0NF 

PaymentsLog ( CustomerFirstName, CustomerLastName, OrderDate, CustomerNumber, <b class="pk">OrderNumber</b>, OrderTotal, <b class="gr">{</b> Date, PaymentAmount, PaymentNumber, BalanceOwing, PaymentType, DepositBatchNumber<b class="gr">}</b> )

## 1NF

After performing First Normal Form, a new entity was made: **Payment**

PaymentsLog ( <b class="pk">OrderNumber</b>, CustomerNumber, OrderTotal, OrderDate, CustomerFirstName, CustomerLastName )

Payment ( <b class="pk"><b class="fk">OrderNumber</b>, PaymentNumber</b>, Date, PaymentAmount, BalanceOwing, PaymentType, DepositBatchNumber )

## 2NF

There are no partial dependencies found.

## 3NF

After performing Third Normal Form, a new entity was made:
**Customer**

PaymentsLog ( <b class="pk">OrderNumber</b>, <u class="fk">CustomerNumber</u>, OrderDate, OrderTotal )

Payment ( <b class="pk"><u class="fk">OrderNumber</u>, PaymentNumber</b>, BalanceOwing, PaymentType, DepositBatchNumber )

Customer ( <b class="pk">CustomerNumber</b>, CustomerFirstName, CustomerLastNumber )





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