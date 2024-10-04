// To parse this JSON data, do
//
//     final invoiceDetailResponseModel = invoiceDetailResponseModelFromJson(jsonString);

import 'dart:convert';

InvoiceDetailResponseModel invoiceDetailResponseModelFromJson(String str) => InvoiceDetailResponseModel.fromJson(json.decode(str));

String invoiceDetailResponseModelToJson(InvoiceDetailResponseModel data) => json.encode(data.toJson());

class InvoiceDetailResponseModel {
  bool? success;
  String? message;
  InvoiceDetailData? data;

  InvoiceDetailResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory InvoiceDetailResponseModel.fromJson(Map<String, dynamic> json) => InvoiceDetailResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : InvoiceDetailData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class InvoiceDetailData {
  String? id;
  String? entity;
  dynamic receipt;
  dynamic invoiceNumber;
  dynamic customerId;
  CustomerDetails? customerDetails;
  String? orderId;
  String? subscriptionId;
  List<LineItem>? lineItems;
  String? paymentId;
  String? status;
  dynamic expireBy;
  int? issuedAt;
  int? paidAt;
  dynamic cancelledAt;
  dynamic expiredAt;
  dynamic smsStatus;
  dynamic emailStatus;
  int? date;
  dynamic terms;
  bool? partialPayment;
  int? grossAmount;
  int? taxAmount;
  int? taxableAmount;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? currencySymbol;
  dynamic description;
  List<dynamic>? notes;
  dynamic comment;
  String? shortUrl;
  bool? viewLess;
  int? billingStart;
  int? billingEnd;
  String? type;
  bool? groupTaxesDiscounts;
  int? createdAt;
  dynamic idempotencyKey;
  dynamic refNum;

  InvoiceDetailData({
    this.id,
    this.entity,
    this.receipt,
    this.invoiceNumber,
    this.customerId,
    this.customerDetails,
    this.orderId,
    this.subscriptionId,
    this.lineItems,
    this.paymentId,
    this.status,
    this.expireBy,
    this.issuedAt,
    this.paidAt,
    this.cancelledAt,
    this.expiredAt,
    this.smsStatus,
    this.emailStatus,
    this.date,
    this.terms,
    this.partialPayment,
    this.grossAmount,
    this.taxAmount,
    this.taxableAmount,
    this.amount,
    this.amountPaid,
    this.amountDue,
    this.currency,
    this.currencySymbol,
    this.description,
    this.notes,
    this.comment,
    this.shortUrl,
    this.viewLess,
    this.billingStart,
    this.billingEnd,
    this.type,
    this.groupTaxesDiscounts,
    this.createdAt,
    this.idempotencyKey,
    this.refNum,
  });

  factory InvoiceDetailData.fromJson(Map<String, dynamic> json) => InvoiceDetailData(
    id: json["id"],
    entity: json["entity"],
    receipt: json["receipt"],
    invoiceNumber: json["invoice_number"],
    customerId: json["customer_id"],
    customerDetails: json["customer_details"] == null ? null : CustomerDetails.fromJson(json["customer_details"]),
    orderId: json["order_id"],
    subscriptionId: json["subscription_id"],
    lineItems: json["line_items"] == null ? [] : List<LineItem>.from(json["line_items"]!.map((x) => LineItem.fromJson(x))),
    paymentId: json["payment_id"],
    status: json["status"],
    expireBy: json["expire_by"],
    issuedAt: json["issued_at"],
    paidAt: json["paid_at"],
    cancelledAt: json["cancelled_at"],
    expiredAt: json["expired_at"],
    smsStatus: json["sms_status"],
    emailStatus: json["email_status"],
    date: json["date"],
    terms: json["terms"],
    partialPayment: json["partial_payment"],
    grossAmount: json["gross_amount"],
    taxAmount: json["tax_amount"],
    taxableAmount: json["taxable_amount"],
    amount: json["amount"],
    amountPaid: json["amount_paid"],
    amountDue: json["amount_due"],
    currency: json["currency"],
    currencySymbol: json["currency_symbol"],
    description: json["description"],
    notes: json["notes"] == null ? [] : List<dynamic>.from(json["notes"]!.map((x) => x)),
    comment: json["comment"],
    shortUrl: json["short_url"],
    viewLess: json["view_less"],
    billingStart: json["billing_start"],
    billingEnd: json["billing_end"],
    type: json["type"],
    groupTaxesDiscounts: json["group_taxes_discounts"],
    createdAt: json["created_at"],
    idempotencyKey: json["idempotency_key"],
    refNum: json["ref_num"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entity": entity,
    "receipt": receipt,
    "invoice_number": invoiceNumber,
    "customer_id": customerId,
    "customer_details": customerDetails?.toJson(),
    "order_id": orderId,
    "subscription_id": subscriptionId,
    "line_items": lineItems == null ? [] : List<dynamic>.from(lineItems!.map((x) => x.toJson())),
    "payment_id": paymentId,
    "status": status,
    "expire_by": expireBy,
    "issued_at": issuedAt,
    "paid_at": paidAt,
    "cancelled_at": cancelledAt,
    "expired_at": expiredAt,
    "sms_status": smsStatus,
    "email_status": emailStatus,
    "date": date,
    "terms": terms,
    "partial_payment": partialPayment,
    "gross_amount": grossAmount,
    "tax_amount": taxAmount,
    "taxable_amount": taxableAmount,
    "amount": amount,
    "amount_paid": amountPaid,
    "amount_due": amountDue,
    "currency": currency,
    "currency_symbol": currencySymbol,
    "description": description,
    "notes": notes == null ? [] : List<dynamic>.from(notes!.map((x) => x)),
    "comment": comment,
    "short_url": shortUrl,
    "view_less": viewLess,
    "billing_start": billingStart,
    "billing_end": billingEnd,
    "type": type,
    "group_taxes_discounts": groupTaxesDiscounts,
    "created_at": createdAt,
    "idempotency_key": idempotencyKey,
    "ref_num": refNum,
  };
}

class CustomerDetails {
  dynamic id;
  dynamic name;
  String? email;
  String? contact;
  dynamic gstin;
  dynamic billingAddress;
  dynamic shippingAddress;
  dynamic customerName;
  String? customerEmail;
  String? customerContact;

  CustomerDetails({
    this.id,
    this.name,
    this.email,
    this.contact,
    this.gstin,
    this.billingAddress,
    this.shippingAddress,
    this.customerName,
    this.customerEmail,
    this.customerContact,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    gstin: json["gstin"],
    billingAddress: json["billing_address"],
    shippingAddress: json["shipping_address"],
    customerName: json["customer_name"],
    customerEmail: json["customer_email"],
    customerContact: json["customer_contact"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "contact": contact,
    "gstin": gstin,
    "billing_address": billingAddress,
    "shipping_address": shippingAddress,
    "customer_name": customerName,
    "customer_email": customerEmail,
    "customer_contact": customerContact,
  };
}

class LineItem {
  String? id;
  dynamic itemId;
  dynamic refId;
  dynamic refType;
  String? name;
  String? description;
  int? amount;
  int? unitAmount;
  int? grossAmount;
  int? taxAmount;
  int? taxableAmount;
  int? netAmount;
  String? currency;
  String? type;
  bool? taxInclusive;
  dynamic hsnCode;
  dynamic sacCode;
  dynamic taxRate;
  dynamic unit;
  int? quantity;
  List<dynamic>? taxes;

  LineItem({
    this.id,
    this.itemId,
    this.refId,
    this.refType,
    this.name,
    this.description,
    this.amount,
    this.unitAmount,
    this.grossAmount,
    this.taxAmount,
    this.taxableAmount,
    this.netAmount,
    this.currency,
    this.type,
    this.taxInclusive,
    this.hsnCode,
    this.sacCode,
    this.taxRate,
    this.unit,
    this.quantity,
    this.taxes,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
    id: json["id"],
    itemId: json["item_id"],
    refId: json["ref_id"],
    refType: json["ref_type"],
    name: json["name"],
    description: json["description"],
    amount: json["amount"],
    unitAmount: json["unit_amount"],
    grossAmount: json["gross_amount"],
    taxAmount: json["tax_amount"],
    taxableAmount: json["taxable_amount"],
    netAmount: json["net_amount"],
    currency: json["currency"],
    type: json["type"],
    taxInclusive: json["tax_inclusive"],
    hsnCode: json["hsn_code"],
    sacCode: json["sac_code"],
    taxRate: json["tax_rate"],
    unit: json["unit"],
    quantity: json["quantity"],
    taxes: json["taxes"] == null ? [] : List<dynamic>.from(json["taxes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_id": itemId,
    "ref_id": refId,
    "ref_type": refType,
    "name": name,
    "description": description,
    "amount": amount,
    "unit_amount": unitAmount,
    "gross_amount": grossAmount,
    "tax_amount": taxAmount,
    "taxable_amount": taxableAmount,
    "net_amount": netAmount,
    "currency": currency,
    "type": type,
    "tax_inclusive": taxInclusive,
    "hsn_code": hsnCode,
    "sac_code": sacCode,
    "tax_rate": taxRate,
    "unit": unit,
    "quantity": quantity,
    "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
  };
}
