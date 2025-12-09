-- ERP / CRM Canonical SQL Schemas (PostgreSQL)
-- File: ERP_CRM_100_Table_Schemas.sql
-- Assumptions: PostgreSQL. Uses gen_random_uuid() from pgcrypto for UUID primary keys.
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Common conventions used across tables:
-- id: UUID primary key
-- code: short natural code or business key
-- name, description: display fields
-- status: small status indicator
-- tenant_id: multi-tenant identifier (nullable)
-- source_system, source_record_id, last_synced_at: integration metadata
-- created_at, updated_at: auditing

-- 1 Account / Organization
CREATE TABLE account (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(100),
  name VARCHAR(400) NOT NULL,
  legal_name VARCHAR(400),
  account_type VARCHAR(50), -- customer / vendor / partner / internal
  industry VARCHAR(200),
  website VARCHAR(255),
  phone VARCHAR(50),
  status VARCHAR(50) DEFAULT 'active',
  tenant_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  last_synced_at TIMESTAMPTZ,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 2 Contact / Person
CREATE TABLE contact (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id UUID REFERENCES account(id),
  first_name VARCHAR(200),
  last_name VARCHAR(200),
  full_name VARCHAR(400),
  email VARCHAR(255),
  phone VARCHAR(50),
  title VARCHAR(200),
  is_primary BOOLEAN DEFAULT FALSE,
  status VARCHAR(50) DEFAULT 'active',
  tenant_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  last_synced_at TIMESTAMPTZ,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 3 User / Employee
CREATE TABLE employee (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  employee_number VARCHAR(100),
  user_id UUID, -- link to auth/user table if exists
  first_name VARCHAR(200),
  last_name VARCHAR(200),
  email VARCHAR(255),
  phone VARCHAR(50),
  department VARCHAR(200),
  manager_id UUID REFERENCES employee(id),
  hire_date DATE,
  termination_date DATE,
  status VARCHAR(50) DEFAULT 'active',
  tenant_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  last_synced_at TIMESTAMPTZ,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 4 Role / Permission
CREATE TABLE role_permission (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(200) NOT NULL,
  description TEXT,
  role_type VARCHAR(100),
  tenant_id UUID,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 5 Address
CREATE TABLE address (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id UUID REFERENCES account(id),
  contact_id UUID REFERENCES contact(id),
  address_type VARCHAR(50), -- billing / shipping / headquarter
  line1 VARCHAR(400),
  line2 VARCHAR(400),
  city VARCHAR(200),
  state VARCHAR(200),
  postal_code VARCHAR(50),
  country VARCHAR(100),
  latitude NUMERIC(10,6),
  longitude NUMERIC(10,6),
  is_default BOOLEAN DEFAULT FALSE,
  tenant_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 6 Customer (alias to account with type)
-- Use account table where account_type='customer'

-- 7 Vendor / Supplier (alias to account where account_type='vendor')

-- 8 Lead
CREATE TABLE lead (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id UUID REFERENCES account(id),
  contact_id UUID REFERENCES contact(id),
  source VARCHAR(200),
  status VARCHAR(50) DEFAULT 'new',
  lead_score INTEGER,
  owner_id UUID, -- employee/responsible
  description TEXT,
  tenant_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  last_synced_at TIMESTAMPTZ,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 9 Opportunity
CREATE TABLE opportunity (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id UUID REFERENCES account(id),
  primary_contact_id UUID REFERENCES contact(id),
  name VARCHAR(400),
  amount NUMERIC(18,2),
  currency CHAR(3),
  stage VARCHAR(100),
  probability NUMERIC(5,2),
  close_date DATE,
  owner_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  tenant_id UUID,
  last_synced_at TIMESTAMPTZ,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 10 Campaign / MarketingCampaign
CREATE TABLE campaign (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(400),
  start_date DATE,
  end_date DATE,
  budget NUMERIC(18,2),
  status VARCHAR(50),
  owner_id UUID,
  channel VARCHAR(100),
  tenant_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 11 Activity / Task
CREATE TABLE activity (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subject VARCHAR(500),
  activity_type VARCHAR(100),
  due_date TIMESTAMPTZ,
  status VARCHAR(50),
  priority INTEGER DEFAULT 2,
  owner_id UUID,
  related_account_id UUID REFERENCES account(id),
  related_contact_id UUID REFERENCES contact(id),
  description TEXT,
  tenant_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 12 Case / ServiceRequest / Ticket
CREATE TABLE service_request (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  case_number VARCHAR(200),
  account_id UUID REFERENCES account(id),
  contact_id UUID REFERENCES contact(id),
  subject VARCHAR(500),
  description TEXT,
  status VARCHAR(50),
  priority VARCHAR(50),
  owner_id UUID,
  resolution TEXT,
  closed_at TIMESTAMPTZ,
  tenant_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 13 Note / Comment
CREATE TABLE note (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_type VARCHAR(100),
  parent_id UUID,
  author_id UUID,
  content TEXT,
  is_public BOOLEAN DEFAULT TRUE,
  tenant_id UUID,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 14 Attachment / Document
CREATE TABLE document (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_type VARCHAR(100),
  parent_id UUID,
  file_name VARCHAR(500),
  mime_type VARCHAR(200),
  file_size BIGINT,
  storage_url TEXT,
  blob BYTEA,
  uploaded_by UUID,
  tenant_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 15 Product / Item / SKU
CREATE TABLE product (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  sku VARCHAR(200) UNIQUE,
  name VARCHAR(400) NOT NULL,
  description TEXT,
  product_category_id UUID,
  unit_of_measure VARCHAR(50),
  weight NUMERIC(12,4),
  dimensions JSONB,
  status VARCHAR(50) DEFAULT 'active',
  tenant_id UUID,
  source_system VARCHAR(100),
  source_record_id VARCHAR(200),
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 16 ProductCategory / ProductFamily
CREATE TABLE product_category (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(200),
  name VARCHAR(400),
  parent_id UUID REFERENCES product_category(id),
  description TEXT,
  tenant_id UUID,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 17 ProductVariant
CREATE TABLE product_variant (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID REFERENCES product(id) ON DELETE CASCADE,
  variant_code VARCHAR(200),
  attributes JSONB,
  sku VARCHAR(200) UNIQUE,
  additional_price NUMERIC(18,4),
  status VARCHAR(50) DEFAULT 'active',
  tenant_id UUID,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 18 PriceList / PricelistVersion
CREATE TABLE price_list (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(400),
  currency CHAR(3),
  effective_from DATE,
  effective_to DATE,
  is_default BOOLEAN DEFAULT FALSE,
  tenant_id UUID,
  source_system VARCHAR(100),
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 19 Price / PriceLine
CREATE TABLE price_line (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  price_list_id UUID REFERENCES price_list(id) ON DELETE CASCADE,
  product_id UUID REFERENCES product(id),
  product_variant_id UUID REFERENCES product_variant(id),
  unit_price NUMERIC(18,4),
  min_quantity NUMERIC(18,4) DEFAULT 1,
  currency CHAR(3),
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 20 UnitOfMeasure
CREATE TABLE unit_of_measure (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(50) UNIQUE,
  name VARCHAR(200),
  conversion_factor NUMERIC(18,8),
  base_unit BOOLEAN DEFAULT FALSE,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 21 Inventory / StockItem
CREATE TABLE inventory_item (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID REFERENCES product(id),
  product_variant_id UUID REFERENCES product_variant(id),
  warehouse_id UUID,
  location_bin VARCHAR(200),
  quantity_on_hand NUMERIC(18,4) DEFAULT 0,
  quantity_available NUMERIC(18,4) DEFAULT 0,
  reserved_quantity NUMERIC(18,4) DEFAULT 0,
  lot_number VARCHAR(200),
  serial_number VARCHAR(200),
  tenant_id UUID,
  last_counted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 22 Warehouse / Location
CREATE TABLE warehouse (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(100),
  name VARCHAR(400),
  address_id UUID REFERENCES address(id),
  capacity NUMERIC(18,2),
  is_active BOOLEAN DEFAULT TRUE,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 23 StockMovement / InventoryTransaction
CREATE TABLE inventory_transaction (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  transaction_type VARCHAR(100), -- receipt, issue, transfer, adjustment
  product_id UUID REFERENCES product(id),
  product_variant_id UUID REFERENCES product_variant(id),
  quantity NUMERIC(18,4),
  from_warehouse_id UUID,
  to_warehouse_id UUID,
  reference_type VARCHAR(100),
  reference_id UUID,
  processed_at TIMESTAMPTZ DEFAULT now(),
  created_by UUID,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 24 StockOnHand / InventoryBalance
CREATE TABLE inventory_balance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID REFERENCES product(id),
  product_variant_id UUID REFERENCES product_variant(id),
  warehouse_id UUID,
  quantity_on_hand NUMERIC(18,4) DEFAULT 0,
  quantity_reserved NUMERIC(18,4) DEFAULT 0,
  quantity_available NUMERIC(18,4) DEFAULT 0,
  last_updated TIMESTAMPTZ DEFAULT now(),
  tenant_id UUID
);

-- 25 Lot / Batch
CREATE TABLE lot (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lot_number VARCHAR(200),
  product_id UUID REFERENCES product(id),
  manufacture_date DATE,
  expiry_date DATE,
  quantity NUMERIC(18,4),
  warehouse_id UUID,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 26 SerialNumber
CREATE TABLE serial_number (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  serial VARCHAR(200) UNIQUE,
  product_id UUID REFERENCES product(id),
  product_variant_id UUID REFERENCES product_variant(id),
  sold BOOLEAN DEFAULT FALSE,
  warranty_expires_at TIMESTAMPTZ,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 27 PurchaseOrder (PO)
CREATE TABLE purchase_order (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  po_number VARCHAR(200) UNIQUE,
  vendor_account_id UUID REFERENCES account(id),
  order_date DATE,
  expected_date DATE,
  status VARCHAR(50),
  currency CHAR(3),
  total_amount NUMERIC(18,4),
  tenant_id UUID,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 28 PurchaseOrderLine (PO lines)
CREATE TABLE purchase_order_line (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  purchase_order_id UUID REFERENCES purchase_order(id) ON DELETE CASCADE,
  line_number INTEGER,
  product_id UUID REFERENCES product(id),
  product_variant_id UUID REFERENCES product_variant(id),
  quantity NUMERIC(18,4),
  unit_price NUMERIC(18,4),
  line_amount NUMERIC(18,4),
  warehouse_id UUID,
  tenant_id UUID
);

-- 29 SalesOrder (SO)
CREATE TABLE sales_order (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  so_number VARCHAR(200) UNIQUE,
  account_id UUID REFERENCES account(id),
  order_date DATE,
  requested_date DATE,
  status VARCHAR(50),
  currency CHAR(3),
  total_amount NUMERIC(18,4),
  tenant_id UUID,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 30 SalesOrderLine (SO lines)
CREATE TABLE sales_order_line (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  sales_order_id UUID REFERENCES sales_order(id) ON DELETE CASCADE,
  line_number INTEGER,
  product_id UUID REFERENCES product(id),
  product_variant_id UUID REFERENCES product_variant(id),
  quantity NUMERIC(18,4),
  unit_price NUMERIC(18,4),
  discount NUMERIC(18,4) DEFAULT 0,
  line_amount NUMERIC(18,4),
  warehouse_id UUID,
  tenant_id UUID
);

-- 31 Invoice / BillingDocument / AR_Invoice
CREATE TABLE invoice (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_number VARCHAR(200) UNIQUE,
  account_id UUID REFERENCES account(id),
  invoice_date DATE,
  due_date DATE,
  status VARCHAR(50),
  currency CHAR(3),
  subtotal NUMERIC(18,4),
  tax_amount NUMERIC(18,4),
  total_amount NUMERIC(18,4),
  related_order_id UUID,
  tenant_id UUID,
  created_by UUID,
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 32 InvoiceLine / BillingLine
CREATE TABLE invoice_line (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_id UUID REFERENCES invoice(id) ON DELETE CASCADE,
  line_number INTEGER,
  product_id UUID REFERENCES product(id),
  quantity NUMERIC(18,4),
  unit_price NUMERIC(18,4),
  tax_amount NUMERIC(18,4),
  line_amount NUMERIC(18,4),
  tenant_id UUID
);

-- 33 CreditMemo / CreditNote
CREATE TABLE credit_memo (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  credit_number VARCHAR(200) UNIQUE,
  account_id UUID REFERENCES account(id),
  credit_date DATE,
  amount NUMERIC(18,4),
  currency CHAR(3),
  reason TEXT,
  status VARCHAR(50),
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 34 Payment / PaymentTransaction
CREATE TABLE payment (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  payment_number VARCHAR(200) UNIQUE,
  account_id UUID REFERENCES account(id),
  invoice_id UUID REFERENCES invoice(id),
  payment_date DATE,
  payment_method VARCHAR(100),
  amount NUMERIC(18,4),
  currency CHAR(3),
  external_reference VARCHAR(500),
  status VARCHAR(50),
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 35 PaymentMethod / PaymentTerm
CREATE TABLE payment_method (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(100),
  name VARCHAR(200),
  description TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 36 BankAccount / CashAccount
CREATE TABLE bank_account (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_number VARCHAR(200),
  bank_name VARCHAR(200),
  routing_number VARCHAR(100),
  currency CHAR(3),
  balance NUMERIC(18,4) DEFAULT 0,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 37 BankStatement / BankTransaction
CREATE TABLE bank_transaction (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  bank_account_id UUID REFERENCES bank_account(id),
  transaction_date DATE,
  amount NUMERIC(18,4),
  currency CHAR(3),
  description TEXT,
  transaction_type VARCHAR(50),
  external_reference VARCHAR(500),
  reconciled BOOLEAN DEFAULT FALSE,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 38 Reconciliation / BankReconciliation
CREATE TABLE bank_reconciliation (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  bank_account_id UUID REFERENCES bank_account(id),
  period_start DATE,
  period_end DATE,
  statement_balance NUMERIC(18,4),
  book_balance NUMERIC(18,4),
  reconciled_at TIMESTAMPTZ,
  status VARCHAR(50),
  tenant_id UUID
);

-- 39 PurchaseInvoice / SupplierInvoice / AP_Invoice
CREATE TABLE supplier_invoice (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_number VARCHAR(200) UNIQUE,
  vendor_account_id UUID REFERENCES account(id),
  invoice_date DATE,
  due_date DATE,
  status VARCHAR(50),
  currency CHAR(3),
  total_amount NUMERIC(18,4),
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 40 Receipt / GoodsReceipt / GRN
CREATE TABLE goods_receipt (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  receipt_number VARCHAR(200) UNIQUE,
  purchase_order_id UUID REFERENCES purchase_order(id),
  received_date DATE,
  warehouse_id UUID,
  status VARCHAR(50),
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 41 Shipment / Delivery
CREATE TABLE shipment (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  shipment_number VARCHAR(200) UNIQUE,
  sales_order_id UUID REFERENCES sales_order(id),
  shipped_date DATE,
  carrier VARCHAR(200),
  tracking_number VARCHAR(400),
  status VARCHAR(50),
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 42 PickList / PickingSlip
CREATE TABLE pick_list (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pick_number VARCHAR(200) UNIQUE,
  warehouse_id UUID,
  created_by UUID,
  status VARCHAR(50),
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 43 ReturnAuthorization / ReturnOrder
CREATE TABLE return_order (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  return_number VARCHAR(200) UNIQUE,
  account_id UUID REFERENCES account(id),
  related_order_id UUID,
  reason TEXT,
  status VARCHAR(50),
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 44 SalesReturn / SupplierReturn
CREATE TABLE product_return (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  return_order_id UUID REFERENCES return_order(id),
  product_id UUID REFERENCES product(id),
  quantity NUMERIC(18,4),
  condition VARCHAR(100),
  processed BOOLEAN DEFAULT FALSE,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 45 TaxCode / TaxRate / VAT_Rate
CREATE TABLE tax_rate (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(100),
  name VARCHAR(200),
  rate NUMERIC(10,6),
  jurisdiction VARCHAR(200),
  effective_from DATE,
  effective_to DATE,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 46 TaxTransaction / TaxJournal
CREATE TABLE tax_transaction (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  source_type VARCHAR(100),
  source_id UUID,
  tax_rate_id UUID REFERENCES tax_rate(id),
  taxable_amount NUMERIC(18,4),
  tax_amount NUMERIC(18,4),
  recorded_at TIMESTAMPTZ DEFAULT now(),
  tenant_id UUID
);

-- 47 Currency / ExchangeRate
CREATE TABLE currency (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code CHAR(3) UNIQUE,
  name VARCHAR(200),
  symbol VARCHAR(10),
  tenant_id UUID
);
CREATE TABLE exchange_rate (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  from_currency CHAR(3) REFERENCES currency(code),
  to_currency CHAR(3) REFERENCES currency(code),
  rate NUMERIC(30,12),
  effective_date DATE,
  tenant_id UUID
);

-- 48 GLAccount / ChartOfAccounts
CREATE TABLE gl_account (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_code VARCHAR(100) UNIQUE,
  name VARCHAR(400),
  account_type VARCHAR(100),
  parent_account_id UUID REFERENCES gl_account(id),
  balance NUMERIC(30,6) DEFAULT 0,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 49 JournalEntry / LedgerEntry
CREATE TABLE journal_entry (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  journal_number VARCHAR(200) UNIQUE,
  posting_date DATE,
  description TEXT,
  currency CHAR(3),
  total_debits NUMERIC(30,6),
  total_credits NUMERIC(30,6),
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE journal_line (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  journal_entry_id UUID REFERENCES journal_entry(id) ON DELETE CASCADE,
  gl_account_id UUID REFERENCES gl_account(id),
  debit NUMERIC(30,6) DEFAULT 0,
  credit NUMERIC(30,6) DEFAULT 0,
  description TEXT
);

-- 50 GeneralLedger / LedgerBalance (summary)
CREATE TABLE ledger_balance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  gl_account_id UUID REFERENCES gl_account(id),
  period_start DATE,
  period_end DATE,
  opening_balance NUMERIC(30,6),
  closing_balance NUMERIC(30,6),
  tenant_id UUID
);

-- 51 CostCenter / Department
CREATE TABLE cost_center (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(100),
  name VARCHAR(200),
  manager_id UUID,
  tenant_id UUID
);

-- 52 Project / Job
CREATE TABLE project (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_code VARCHAR(200),
  name VARCHAR(400),
  description TEXT,
  start_date DATE,
  end_date DATE,
  budget NUMERIC(30,6),
  status VARCHAR(50),
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 53 ProjectTask / ProjectLine
CREATE TABLE project_task (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID REFERENCES project(id) ON DELETE CASCADE,
  name VARCHAR(400),
  assigned_to UUID,
  start_date DATE,
  end_date DATE,
  effort_hours NUMERIC(12,2),
  status VARCHAR(50),
  tenant_id UUID
);

-- 54 Timesheet / TimeEntry
CREATE TABLE timesheet_entry (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID REFERENCES project(id),
  task_id UUID REFERENCES project_task(id),
  employee_id UUID REFERENCES employee(id),
  work_date DATE,
  hours NUMERIC(6,2),
  billable BOOLEAN DEFAULT TRUE,
  notes TEXT,
  tenant_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 55 Expense / ExpenseReport
CREATE TABLE expense_report (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  report_number VARCHAR(200) UNIQUE,
  employee_id UUID REFERENCES employee(id),
  total_amount NUMERIC(18,4),
  currency CHAR(3),
  status VARCHAR(50),
  submitted_at TIMESTAMPTZ,
  approved_at TIMESTAMPTZ,
  tenant_id UUID
);

-- 56 Asset / FixedAsset
CREATE TABLE fixed_asset (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  asset_tag VARCHAR(200) UNIQUE,
  name VARCHAR(400),
  description TEXT,
  acquisition_date DATE,
  acquisition_cost NUMERIC(30,6),
  depreciation_method VARCHAR(100),
  useful_life_years INTEGER,
  net_book_value NUMERIC(30,6),
  location_id UUID,
  tenant_id UUID
);

-- 57 AssetTransaction / AssetDepreciation
CREATE TABLE asset_transaction (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  asset_id UUID REFERENCES fixed_asset(id),
  transaction_type VARCHAR(100),
  amount NUMERIC(30,6),
  transaction_date DATE,
  notes TEXT
);

-- 58 BillOfMaterials (BOM)
CREATE TABLE bill_of_materials (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID REFERENCES product(id),
  bom_code VARCHAR(200),
  version VARCHAR(50),
  status VARCHAR(50),
  tenant_id UUID
);
CREATE TABLE bom_line (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  bill_of_materials_id UUID REFERENCES bill_of_materials(id) ON DELETE CASCADE,
  component_product_id UUID REFERENCES product(id),
  quantity NUMERIC(18,6),
  unit_of_measure VARCHAR(50)
);

-- 59 Routing / Operation / WorkCenter
CREATE TABLE work_center (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(200),
  name VARCHAR(400),
  capacity NUMERIC(12,2),
  tenant_id UUID
);
CREATE TABLE routing_operation (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  work_center_id UUID REFERENCES work_center(id),
  operation_code VARCHAR(200),
  description TEXT,
  setup_time_minutes INTEGER,
  run_time_minutes INTEGER
);

-- 60 WorkOrder / ProductionOrder
CREATE TABLE production_order (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_number VARCHAR(200) UNIQUE,
  product_id UUID REFERENCES product(id),
  quantity NUMERIC(18,4),
  start_date DATE,
  end_date DATE,
  status VARCHAR(50),
  tenant_id UUID
);

-- 61 ManufacturingOrderLine / OperationLine
CREATE TABLE production_operation_line (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  production_order_id UUID REFERENCES production_order(id) ON DELETE CASCADE,
  operation_id UUID REFERENCES routing_operation(id),
  sequence INTEGER,
  scheduled_start TIMESTAMPTZ,
  scheduled_end TIMESTAMPTZ,
  actual_start TIMESTAMPTZ,
  actual_end TIMESTAMPTZ
);

-- 62 QualityInspection / QualityCheck / QC_Result
CREATE TABLE quality_inspection (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  related_type VARCHAR(100),
  related_id UUID,
  inspection_date TIMESTAMPTZ,
  inspector_id UUID,
  result VARCHAR(50),
  notes TEXT,
  tenant_id UUID
);

-- 63 SupplierCatalog / VendorCatalog
CREATE TABLE supplier_catalog (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vendor_account_id UUID REFERENCES account(id),
  product_id UUID REFERENCES product(id),
  vendor_sku VARCHAR(200),
  lead_time_days INTEGER,
  min_order_quantity NUMERIC(18,4)
);

-- 64 ProcurementRequest / Requisition
CREATE TABLE requisition (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  requisition_number VARCHAR(200) UNIQUE,
  requested_by UUID,
  department_id UUID,
  status VARCHAR(50),
  total_amount NUMERIC(18,4),
  tenant_id UUID
);

-- 65 Approval / ApprovalWorkflow / ApprovalTask
CREATE TABLE approval_task (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  approval_type VARCHAR(100),
  reference_type VARCHAR(100),
  reference_id UUID,
  approver_id UUID,
  status VARCHAR(50),
  comments TEXT,
  requested_at TIMESTAMPTZ,
  responded_at TIMESTAMPTZ
);

-- 66 WorkflowDefinition / WorkflowInstance
CREATE TABLE workflow_definition (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(400),
  key VARCHAR(200),
  definition JSONB,
  is_active BOOLEAN DEFAULT TRUE,
  tenant_id UUID
);
CREATE TABLE workflow_instance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  workflow_definition_id UUID REFERENCES workflow_definition(id),
  status VARCHAR(50),
  state JSONB,
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ
);

-- 67 Contract / Agreement / SLA
CREATE TABLE contract (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  contract_number VARCHAR(200) UNIQUE,
  name VARCHAR(400),
  account_id UUID REFERENCES account(id),
  start_date DATE,
  end_date DATE,
  value NUMERIC(30,6),
  status VARCHAR(50),
  tenant_id UUID
);

-- 68 Subscription / License / Entitlement
CREATE TABLE subscription (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subscription_number VARCHAR(200) UNIQUE,
  account_id UUID REFERENCES account(id),
  product_id UUID REFERENCES product(id),
  start_date DATE,
  end_date DATE,
  billing_cycle VARCHAR(50),
  status VARCHAR(50),
  tenant_id UUID
);

-- 69 SLARecord / ServiceLevel
CREATE TABLE sla_record (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  contract_id UUID REFERENCES contract(id),
  metric VARCHAR(200),
  threshold NUMERIC(18,4),
  period VARCHAR(50),
  tenant_id UUID
);

-- 70 PriceBook / ContractPrice
CREATE TABLE contract_price (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  contract_id UUID REFERENCES contract(id),
  product_id UUID REFERENCES product(id),
  price NUMERIC(18,4),
  currency CHAR(3)
);

-- 71 Discount / Promotion / Coupon
CREATE TABLE promotion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(200) UNIQUE,
  name VARCHAR(400),
  discount_type VARCHAR(50),
  value NUMERIC(18,4),
  valid_from DATE,
  valid_to DATE,
  usage_limit INTEGER,
  tenant_id UUID
);

-- 72 TaxJurisdiction / TaxPeriod
CREATE TABLE tax_jurisdiction (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(400),
  country VARCHAR(100),
  region VARCHAR(100),
  tenant_id UUID
);

-- 73 ShipmentTracking / TrackingEvent
CREATE TABLE tracking_event (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  shipment_id UUID REFERENCES shipment(id),
  event_time TIMESTAMPTZ,
  location VARCHAR(400),
  event_type VARCHAR(200),
  description TEXT
);

-- 74 ShippingMethod / Carrier
CREATE TABLE carrier (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(200),
  name VARCHAR(400),
  contact_info JSONB,
  tenant_id UUID
);

-- 75 Notification / Alert / MessageQueue
CREATE TABLE notification (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  notification_type VARCHAR(100),
  recipient_id UUID,
  payload JSONB,
  status VARCHAR(50),
  sent_at TIMESTAMPTZ,
  processed_at TIMESTAMPTZ
);

-- 76 EmailTemplate / MessageTemplate
CREATE TABLE email_template (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(400),
  subject VARCHAR(500),
  body TEXT,
  language CHAR(5),
  tenant_id UUID
);

-- 77 AuditLog / ChangeHistory / AuditTrail
CREATE TABLE audit_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  entity_type VARCHAR(200),
  entity_id UUID,
  action VARCHAR(100),
  changed_by UUID,
  change_payload JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 78 Session / LoginSession / AuthToken
CREATE TABLE login_session (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID,
  session_token VARCHAR(500),
  ip_address VARCHAR(100),
  user_agent TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  expires_at TIMESTAMPTZ
);

-- 79 APIKey / IntegrationCredential
CREATE TABLE api_key (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(200),
  key_hash VARCHAR(500),
  scopes TEXT[],
  active BOOLEAN DEFAULT TRUE,
  owner_id UUID,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 80 IntegrationLog / SyncLog / ETL_Log
CREATE TABLE integration_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  integration_name VARCHAR(200),
  operation VARCHAR(100),
  source_system VARCHAR(200),
  target_system VARCHAR(200),
  status VARCHAR(50),
  message TEXT,
  started_at TIMESTAMPTZ,
  ended_at TIMESTAMPTZ
);

-- 81 ImportJob / ExportJob / DataLoadJob
CREATE TABLE data_job (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_type VARCHAR(50),
  file_name VARCHAR(500),
  status VARCHAR(50),
  rows_processed BIGINT,
  error_count BIGINT,
  started_at TIMESTAMPTZ,
  finished_at TIMESTAMPTZ
);

-- 82 CustomField / ExtendedAttribute / EntityAttribute
CREATE TABLE custom_field (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  entity_type VARCHAR(200),
  entity_id UUID,
  field_name VARCHAR(200),
  field_value TEXT,
  field_type VARCHAR(50),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 83 LookupTable / ReferenceData / CodeTable
CREATE TABLE lookup (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  category VARCHAR(200),
  code VARCHAR(200),
  label VARCHAR(500),
  sort_order INTEGER,
  tenant_id UUID
);

-- 84 Configuration / SystemSetting / Parameter
CREATE TABLE system_setting (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  key VARCHAR(500) UNIQUE,
  value TEXT,
  description TEXT,
  tenant_id UUID
);

-- 85 CurrencyRateHistory / FXHistory
-- (Use exchange_rate table created earlier)

-- 86 Budget / Forecast / FinancialPlan
CREATE TABLE budget (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(400),
  period_start DATE,
  period_end DATE,
  amount NUMERIC(30,6),
  currency CHAR(3),
  tenant_id UUID
);

-- 87 Commitment / Reservation / Allocation
CREATE TABLE allocation (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID REFERENCES product(id),
  reference_type VARCHAR(100),
  reference_id UUID,
  quantity NUMERIC(18,4),
  allocated_at TIMESTAMPTZ,
  tenant_id UUID
);

-- 88 Commission / CommissionSchedule
CREATE TABLE commission_schedule (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(400),
  description TEXT,
  rules JSONB,
  tenant_id UUID
);

-- 89 BillingSchedule / RecurringBillingRule
CREATE TABLE billing_schedule (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(400),
  frequency VARCHAR(50),
  next_billing_date DATE,
  tenant_id UUID
);

-- 90 PriceAgreement / VendorContractPrice
-- (Use contract_price table above)

-- 91 PurchaseReceiptLine / GoodsIssue
CREATE TABLE goods_receipt_line (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  goods_receipt_id UUID REFERENCES goods_receipt(id) ON DELETE CASCADE,
  product_id UUID REFERENCES product(id),
  quantity NUMERIC(18,4),
  unit_price NUMERIC(18,4),
  line_amount NUMERIC(18,4)
);

-- 92 PickTicket / PackingSlip
CREATE TABLE packing_slip (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slip_number VARCHAR(200) UNIQUE,
  shipment_id UUID REFERENCES shipment(id),
  printed_at TIMESTAMPTZ,
  tenant_id UUID
);

-- 93 ReturnLine / CreditLine
CREATE TABLE credit_line (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  credit_memo_id UUID REFERENCES credit_memo(id) ON DELETE CASCADE,
  invoice_line_id UUID,
  amount NUMERIC(18,4),
  reason TEXT
);

-- 94 ComplianceRecord / RegulatoryDocument
CREATE TABLE compliance_record (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  entity_type VARCHAR(200),
  entity_id UUID,
  document_type VARCHAR(200),
  document_reference VARCHAR(500),
  valid_from DATE,
  valid_to DATE,
  notes TEXT
);

-- 95 RiskRecord / AuditFinding
CREATE TABLE risk_record (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(400),
  description TEXT,
  severity VARCHAR(50),
  status VARCHAR(50),
  owner_id UUID,
  detected_at TIMESTAMPTZ
);

-- 96 LegalEntity / CompanyStructure
CREATE TABLE legal_entity (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(400),
  registration_number VARCHAR(200),
  country VARCHAR(100),
  parent_entity_id UUID REFERENCES legal_entity(id),
  tenant_id UUID
);

-- 97 VendorRating / SupplierPerformance
CREATE TABLE supplier_performance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vendor_account_id UUID REFERENCES account(id),
  rating NUMERIC(3,2),
  last_rating_date DATE,
  notes TEXT
);

-- 98 AssetLocation / AssetTag
CREATE TABLE asset_location (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  asset_id UUID REFERENCES fixed_asset(id),
  location_code VARCHAR(200),
  moved_at TIMESTAMPTZ,
  tenant_id UUID
);

-- 99 Barcode / UPC / GTIN
CREATE TABLE barcode (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID REFERENCES product(id),
  type VARCHAR(50), -- UPC / GTIN / EAN
  code VARCHAR(200),
  active BOOLEAN DEFAULT TRUE
);

-- 100 KnowledgeBaseArticle / FAQ
CREATE TABLE knowledge_base_article (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(500),
  summary TEXT,
  content TEXT,
  category VARCHAR(200),
  version VARCHAR(50),
  published BOOLEAN DEFAULT FALSE,
  published_at TIMESTAMPTZ,
  tenant_id UUID
);

-- Indexes (examples)
CREATE INDEX idx_account_name ON account(lower(name));
CREATE INDEX idx_product_sku ON product(sku);
CREATE INDEX idx_sales_order_number ON sales_order(so_number);

-- End of schema file
