abstract class CategoryProductsStates {}

class CategoryProductsInitialState extends CategoryProductsStates {}

class CategoryProductsLoadingState extends CategoryProductsStates {}

class CategoryProductsGetSuccessState extends CategoryProductsStates {}

class CategoryProductsGetFailState extends CategoryProductsStates {}

class ChangeProductFavoriteStatus extends CategoryProductsStates {}
