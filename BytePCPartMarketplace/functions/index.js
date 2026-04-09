/* eslint-disable */
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { defineSecret } = require("firebase-functions/params");
const { Resend } = require("resend");

const resendApiKey = defineSecret("RESEND_API_KEY");

exports.sendInvoiceEmail = onDocumentCreated(
  { document: "orders/{orderId}", secrets: [resendApiKey] },
  async (event) => {
    const order = event.data?.data();

    if (!order) {
      console.error("No order data found.");
      return;
    }

    const orderId = event.params.orderId;

    const {
      buyerEmail,
      buyerName,
      paymentMethod,
      shippingAddress,
      shippingCity,
      shippingState,
      shippingPostalCode,
      shippingCountry,
      items = [],
      total,
      createdAt,
    } = order;

    if (!buyerEmail) {
      console.error(`Missing buyerEmail for order ${orderId}`);
      return;
    }

    const resend = new Resend(resendApiKey.value());

    const formattedDate = createdAt?.toDate
      ? createdAt.toDate().toLocaleDateString("en-CA", {
          year: "numeric",
          month: "long",
          day: "numeric",
        })
      : "N/A";

    const currencyFormat = (amount) =>
      new Intl.NumberFormat("en-CA", {
        style: "currency",
        currency: "CAD",
      }).format(amount || 0);

    const itemsHtml = items
      .map(
        (item) => `
            <tr>
              <td>
                <div style="font-weight: 500;">${item.title || "Item"}</div>
                <div style="color: #888; font-size: 12px; margin-top:
                    4px;">${item.category || "N/A"} · ${
                      item.condition || "N/A"
                    }</div>
              </td>
              <td style="text-align: right;">${currencyFormat(item.price)}</td>
            </tr>`,
      )
      .join("");

    const emailHtml = `<!DOCTYPE html>
<html>
<head>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI',
        Arial, sans-serif;
      color: #333;
      line-height: 1.6;
    }
    .container {
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
    }
    .header {
      background: #f8f9fa;
      padding: 24px;
      border-radius: 8px;
      text-align: center;
      margin-bottom: 24px;
    }
    .success-icon {
      font-size: 48px;
      margin-bottom: 12px;
    }
    .invoice-title {
      font-size: 24px;
      font-weight: bold;
      margin: 12px 0 0 0;
    }
    .invoice-box {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 24px;
      margin-bottom: 24px;
    }
    .section-title {
      font-size: 14px;
      font-weight: bold;
      color: #666;
      text-transform: uppercase;
      margin: 16px 0 8px 0;
    }
    .info-row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 8px;
      font-size: 14px;
    }
    .info-label {
      color: #888;
    }
    .info-value {
      font-weight: 500;
    }
    .divider {
      border-top: 1px solid #eee;
      margin: 16px 0;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin: 16px 0;
    }
    th {
      text-align: left;
      padding: 12px 0;
      border-bottom: 2px solid #f0f0f0;
      font-weight: 600;
      font-size: 13px;
    }
    td {
      padding: 12px 0;
      border-bottom: 1px solid #f0f0f0;
      font-size: 14px;
    }
    .total-row {
      display: flex;
      justify-content: space-between;
      font-size: 16px;
      font-weight: bold;
      margin-top: 16px;
      padding-top: 16px;
      border-top: 2px solid #f0f0f0;
    }
    .address-block {
      font-size: 13px;
      color: #555;
      line-height: 1.8;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <div class="success-icon">✓</div>
      <div class="invoice-title">Order Confirmed</div>
    </div>

    <div class="invoice-box">
      <div class="section-title">Customer Information</div>
      <div class="info-row">
        <span class="info-label">Customer Name:</span>
        <span class="info-value">${buyerName || "N/A"}</span>
      </div>
      <div class="info-row">
        <span class="info-label">Email:</span>
        <span class="info-value">${buyerEmail}</span>
      </div>

      <div class="divider"></div>

      <div class="section-title">Order Details</div>
      <div class="info-row">
        <span class="info-label">Order ID:</span>
        <span class="info-value">${orderId}</span>
      </div>
      <div class="info-row">
        <span class="info-label">Order Date:</span>
        <span class="info-value">${formattedDate}</span>
      </div>
      <div class="info-row">
        <span class="info-label">Payment Method:</span>
        <span class="info-value">${paymentMethod || "N/A"}</span>
      </div>

      <div class="divider"></div>

      <div class="section-title">Shipping Address</div>
      <div class="address-block">
        ${shippingAddress ? shippingAddress + "<br/>" : ""}${
          shippingCity ? shippingCity + ", " : ""
        }${shippingState ? shippingState + " " : ""}${
          shippingPostalCode ? shippingPostalCode + "<br/>" : ""
        }${shippingCountry ? shippingCountry : ""}
      </div>

      <div class="divider"></div>

      <div class="section-title">Order Summary</div>
      <table>
        <thead>
          <tr>
            <th>Item</th>
            <th style="text-align: right;">Price</th>
          </tr>
        </thead>
        <tbody>
          ${itemsHtml}
        </tbody>
      </table>

      <div class="total-row">
        <span>Order Total:</span>
        <span>${currencyFormat(total)}</span>
      </div>
    </div>

    <p style="text-align: center; color: #888; font-size: 12px;">
      Thank you for your purchase at BYTE Marketplace!
    </p>
  </div>
</body>
</html>`;

    try {
      await resend.emails.send({
        from: "BYTE Marketplace <onboarding@resend.dev>",
        to: buyerEmail,
        subject: `Your BYTE Order Confirmation – ${orderId}`,
        html: emailHtml,
      });

      console.log(`✅ Invoice sent to ${buyerEmail} for order ${orderId}`);
    } catch (error) {
      console.error(`❌ Failed to send invoice email:`, error);
    }
  },
);
