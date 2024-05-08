create database shop_noi_that
use shop_noi_that
-- bảng lữu trữ Admin , Customer, sales, MKT, Guest
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,
    UserName NVARCHAR(30) NOT NULL,
    Gender CHAR(1) NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(15) NOT NULL UNIQUE,
    Address VARCHAR(100) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    Avatar NVARCHAR(255) NULL,
    Password VARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    LastLogin DATETIME NULL
);
--bảng lữu trữ các blogs được đăng
CREATE TABLE Blogs (
    BlogID INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(100) NOT NULL,
	
    Content TEXT NOT NULL,
    AuthorID INT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AuthorID) REFERENCES Users(UserID)
);
-- bảng lưu trữ các ảnh của blog
CREATE TABLE BlogsImages (
    ImageID INT PRIMARY KEY IDENTITY,
    BlogID INT NOT NULL,
    ImagePath NVARCHAR(500) NOT NULL,
    FOREIGN KEY (BlogID) REFERENCES Blogs(BlogID)
);
--bảng lữu trữ bình luận về blog
CREATE TABLE Comments (
    CommentID INT PRIMARY KEY IDENTITY,
    BlogID INT NOT NULL,
    UserID INT NOT NULL, 
    CommentContent NVARCHAR(MAX) NOT NULL,
    CommentDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (BlogID) REFERENCES Blogs(BlogID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
-- bảng lữu trữ brand và thông tin brand , trạng thái brand 
CREATE TABLE Brands (
    BrandID INT PRIMARY KEY IDENTITY,
    BrandName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    IsActive BIT NOT NULL DEFAULT 1
);
-- bảng lữu trữ Categories và thông tin Categories , trạng thái Categories 
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    IsActive BIT NOT NULL DEFAULT 1
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY,
    ProductName NVARCHAR(100) NOT NULL,
    BrandID INT NOT NULL,
    CategoryID INT NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(18, 2) NOT NULL,
    QuantityInStock INT NOT NULL DEFAULT 0,-- số lượng hàng tồn kho 
    Views INT NOT NULL DEFAULT 0,-- số lượt xem 
    Purchases INT NOT NULL DEFAULT 0,-- số lượt mua 
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    IsActive BIT NOT NULL DEFAULT 1,

    FOREIGN KEY (BrandID) REFERENCES Brands(BrandID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE ProductDetails (
    DetailID INT PRIMARY KEY IDENTITY,
    ProductID INT NOT NULL,
    Color NVARCHAR(50),
    Size NVARCHAR(20),
    Material NVARCHAR(50),
    Weight DECIMAL(18, 2),
    Dimensions NVARCHAR(100),
    Description NVARCHAR(MAX),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE ProductImages (
    ImageID INT PRIMARY KEY IDENTITY,
    ProductID INT NOT NULL,
    ImagePath NVARCHAR(500) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE ProductReviews (
    ReviewID INT PRIMARY KEY IDENTITY,
    ProductID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT NOT NULL,
    Comment NVARCHAR(MAX),
    ImagePath NVARCHAR(500),
    VideoPath NVARCHAR(500),
    ReviewDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
CREATE TABLE ProductPromotions (
    ProductPromotionID INT PRIMARY KEY IDENTITY,
    ProductID INT NOT NULL,
    PromoCodeID INT NOT NULL,
    Discount DECIMAL(5, 2) NOT NULL, -- Discount as percentage
    IsActive BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (PromoCodeID) REFERENCES Promotions(PromoCodeID)
);

CREATE TABLE ShippingMethods (
    ShippingID INT PRIMARY KEY IDENTITY,
    ShippingMethodName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    IsActive BIT NOT NULL DEFAULT 1
);

CREATE TABLE PaymentMethods (
    PaymentMethodID INT PRIMARY KEY IDENTITY,
    PaymentMethodName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    IsActive BIT NOT NULL DEFAULT 1
);

CREATE TABLE Promotions (
    PromoCodeID INT PRIMARY KEY IDENTITY,
    PromoCode NVARCHAR(20) NOT NULL UNIQUE,
    Description NVARCHAR(MAX),
    Discount DECIMAL(5, 2) NOT NULL, -- Discount as percentage
    IsActive BIT NOT NULL DEFAULT 1
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY,
    UserID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(18, 2) NOT NULL,
    ShippingID INT NOT NULL,
    PaymentMethodID INT NOT NULL,
    PromoCodeID INT,
	OrderStatus NVARCHAR(50) NOT NULL,-- miêu tả trạng thái đơn hàng như Đã đặt , đang giao , đã giao , đã hủy 
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ShippingID) REFERENCES ShippingMethods(ShippingID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID),
    FOREIGN KEY (PromoCodeID) REFERENCES Promotions(PromoCodeID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


