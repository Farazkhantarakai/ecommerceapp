enum Status {
  cancelled,
  pending,
  processing,
  completed,
}

// extension ExtensionStatus on Status {
//   String toJson() {
//     switch (this) {
//       case Status.pending:
//         return 'Pending';
//       case Status.completed:
//         return 'Completed';
//       case Status.processing:
//         return 'Processing';
//       case Status.cancelled:
//         return 'Cancelled';
//       default:
//         return '';
//     }
//   }

// Map<String, dynamic> toEncodable() {
//   return {
//     'status': this.toJson(),
//   };

class OrderItem {
  String? id;
  String? amounts;
  Map<String, dynamic>? products;
  int? dateTime;
  String? status;
  String? name;
  String? address;
  String? email;
  String? paymentMethod;

  OrderItem(
      {this.id,
      this.amounts,
      this.products,
      this.dateTime,
      this.status,
      this.name,
      this.address,
      this.email,
      this.paymentMethod});

  static String statusToString(Status status) {
    switch (status) {
      case Status.pending:
        return 'pending';
      case Status.cancelled:
        return 'cancelled';
      case Status.completed:
        return 'Ordered';
      default:
        throw ArgumentError('Invalid status: $status');
    }
  }
}
