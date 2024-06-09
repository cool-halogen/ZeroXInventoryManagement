# Note:
## Each task can be referred as an individual commit in the git history of this repository.

Backend System for Inventory Management and Order Processing
Setup Instructions
**Clone the repository:**
```bash
git clone https://github.com/cool-halogen/ZeroXInventoryManagement.git
cd ZeroXInventoryManagement
```
**Install Ruby and Rails:**

Ensure you have Ruby installed. If not, download and install it from ruby-lang.org.
Install Rails by running:
```bash
gem install rails
```
Install dependencies:
```bash
bundle install
```

**Set up the database:**

```bash
rails db:create
rails db:migrate
```

**Run the server:**
```bash
rails server
```
API Endpoints:

`POST /inventory/init_catalog: Initialize the catalog.`

`POST /inventory/process_order: Process an order.`

`POST /inventory/process_restock: Process restock.`

Example Requests
Initialize Catalog: POST /inventory/init_catalog
```json
{
  "products": [
    {"product_id": 0, "product_name": "TNT 26B", "mass_kg": 70}
  ]
}
```
Process Order: POST /inventory/process_order
```json
{
  "order_id": 1,
  "requested": [
    {"product_id": 0, "quantity": 1}
  ]
}
```
Process Restock: POST /inventory/process_restock
```json
{
  "restock": [
    {"product_id": 0, "quantity": 100}
  ]
}
```

**Frontend Interface for Autonomous Trucks**
Setup Instructions
Navigate to the frontend directory:

```bash
cd zerox-frontend
```
Install dependencies:

```bash
npm install
```

Run the React app:

```bash
npm start
```
Drag-and-Drop Interface:

The interface allows dragging trucks from a list of trucks to different stations.
The app uses react-beautiful-dnd for drag-and-drop functionality.

Sample screenshot.
[Screenshot-2024-06-09-at-2-45-58-PM.png](https://postimg.cc/gr229ZXH)

**Database Indexing and Query Optimization**
Setup Instructions
Add indexes to the database:

Updated the migration files to include necessary indexes.
```ruby
class AddIndexesToProductsAndOrders < ActiveRecord::Migration[6.1]
  def change
    add_index :products, :product_id
    add_index :orders, :order_id
  end
end
```
Run the migration:

```bash
rails db:migrate
```

**Optimize Queries:**

Used eager loading and optimized queries as shown in the InventoryController.

**Scripting & DevOps**

Run following rake task

```bash
bundle exec rake deploy:sort_and_deploy
```

Sorts data by mine site.
Creates SQLite databases for each mine site.
Simulates deployment by copying databases to different regions.

**Test Driven Development**
Script is kept in  `lib/factorial.rb` folder.

Setup Instructions

```bash
cd ZeroXInventoryManagement
```
Run RSpec tests:

```bash
bundle exec rspec ./test/factorial_spec.rb
```

**Unit Tests:**
Located in the test directory.
Ensure the functionality of the Inventory Management system.
```bash
bundle exec rspec ./
```
