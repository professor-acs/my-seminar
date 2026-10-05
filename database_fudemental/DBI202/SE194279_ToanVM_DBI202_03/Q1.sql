CREATE TABLE Users (
    Username nvarchar(30) PRIMARY KEY,
    Password nvarchar(20) NOT NULL,
    Email nvarchar(200) NOT NULL
);
CREATE TABLE Roles (
    RoleID int PRIMARY KEY,
    Name nvarchar(100) NOT NULL
);
CREATE TABLE Permissions (
    PermissionID int PRIMARY KEY,
    Name nvarchar(50) NOT NULL
);
CREATE TABLE Role_Permissions (
    RoleID int,
    PermissionID int,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID)
);
