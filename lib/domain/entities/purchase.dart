class Purchase {
    Purchase({
    required this.productId,
    required this.purchaseTimeMillis,
    required this.purchaseState,
    required this.orderId,
    required this.purchaseType,
    required this.purchaseToken,
    });

    String productId;
    int purchaseTimeMillis;
    int purchaseState;
    String orderId;
    int purchaseType;
    String purchaseToken;
}