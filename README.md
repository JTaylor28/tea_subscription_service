# TEA Subscription Service

## Summary
<center>
The Tea Subscription app is an API that allows users to create various tea subscriptions. Customers can choose their preferred teas, set the frequency of their deliveries, and change their subscription status. The app provides endpoints for subscribing, canceling, and viewing subscriptions.
</center>
<br>
<br>
<br>

![Screenshot 2023-06-09 at 10 38 31 AM](https://github.com/JTaylor28/tea_subscription_service/assets/117054959/8ecbfb39-d242-43e7-872f-6d574c2264e6)

<br>

## Built With:

Ruby **3.1.1**
Rails **7.0.4**
Postgresql **1.1**

### Testing:

RSpec
SimpleCov

## Setup

1. Fork and Clone the repository
```shell
git clone git@github.com:JTaylor28/tea_subscription_service.git
```

2. Navigate to the directory
```shell
cd tea_subscription_service
```

3. Install Gem Packages
```shell
bundle install
```

4. Update Gem Packages
```shell
bundle update
```

5. Run the Migrations
```shell
rails db:{drop,create,migrate,seed}
```
<br>

## Schema
![Screenshot 2023-06-09 at 10 30 36 AM](https://github.com/JTaylor28/tea_subscription_service/assets/117054959/946eb01f-320f-4e1e-89a8-3acd6f65fc8b)
<br>


## Endpoints

<details>
<summary> GET "/api/v1/customers/1/subscriptions" </summary>


## Response:

status: 200
body:

```json
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "Green Tea Subscription",
                "price": 10,
                "status": "active",
                "frequency": "monthly",
                "customer_id": 1,
                "tea_id": 1
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "Oolong Tea Subscription",
                "price": 15,
                "status": "cancelled",
                "frequency": "weekly",
                "customer_id": 1,
                "tea_id": 2
            }
        },
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "title": "Earl Gray Tea Subscription",
                "price": 100,
                "status": "cancelled",
                "frequency": "yearly",
                "customer_id": 1,
                "tea_id": 3
            }
        }
    ]
}
```
<br>
<br>
<br>
</details>

<details>
<summary> POST /api/v1/customers/1/subscriptions </summary>

## Request:

Content-Type: application/json
Accept: application/json

```json
{
    "tea_id": "1",
    "frequency": "weekly" 
}
```

## Response:

status: 201
body:

```json
{
    "data": {
        "id": "5",
        "type": "subscription",
        "attributes": {
            "title": "Green Tea Subscription",
            "price": 10,
            "status": "active",
            "frequency": "weekly",
            "customer_id": 1,
            "tea_id": 1
        }
    }
}
```
<br>
<br>
<br>
</details>

<details>
<summary> PATCH /api/v1/customers/1/subscriptions/1 </summary>
<br>

## Change Status: 
### Request:

Content-Type: application/json
Accept: application/json

body:

```json
{
  "status": "cancelled"
}
```

### Response:

status: 200
body:

```json
{
    "data": {
        "id": "6",
        "type": "subscription",
        "attributes": {
            "title": "Green Tea Subscription",
            "price": 10,
            "status": "canceled",
            "frequency": "weekly",
            "customer_id": 1,
            "tea_id": 1
        }
    }
}
```
</details>
