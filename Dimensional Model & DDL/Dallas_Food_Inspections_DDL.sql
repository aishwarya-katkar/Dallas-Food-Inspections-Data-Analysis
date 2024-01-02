-- Dallas Food Inspections
-- Dimensional Model
-- r sherman
-- 2022-10-08

CREATE TABLE dbo.Dim_Dallas_Geo (
	GeoSK int NOT NULL identity(1,1),
	Street_Number int NULL,
	Street_Name varchar(25) NULL,
	Street_Direction char(1) NULL,
	Street_Type char(4) NULL,
	Street_Unit char(5) NULL,
	Street_Address varchar(36) NULL,
	Zip_Code char(10) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (GeoSK)
);

CREATE TABLE dbo.Dim_Dallas_InspectionType (
	InspectionTypeSK int NOT NULL identity(1,1),
	Inspection_Type char(9) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
                PRIMARY KEY (InspectionTypeSK)
);

CREATE TABLE dbo.Dim_Dallas_Restaurant (
	RestaurantSK int NOT NULL identity(1,1),
	Restaurant_Name varchar(65) NULL,
	Street_Number int NULL,
	Street_Name varchar(25) NULL,
	Street_Direction char(1) NULL,
	Street_Type char(4) NULL,
	Street_Unit char(5) NULL,
	Street_Address varchar(36) NULL,
	Zip_Code char(10) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (RestaurantSK)
);

CREATE TABLE dbo.FCT_Dallas_FoodInspection (
	InspectionSK int NOT NULL,
	InspectionDateSK char(8) NULL,
	InspectionDate date NULL,
	Inspection_Month char(8) NULL,
	Inspection_Year char(6) NULL,
	RestaurantSK int NULL,
	GeoSK int NULL,
	Inspection_Date char(10) NULL,
	InspectionTypeSK int NULL,
	Inspection_Score int NULL,
	Lat_Long_Location varchar(59) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (InspectionSK)
);

CREATE TABLE dbo.FCT_Dallas_FoodInspection_Violations (
	InspectionViolationsSK int NOT NULL,
	InspectionSK int NULL,
	Violation_No int NULL,
	Violation_Points int NULL,
	Violation_Detail nvarchar(MAX) NULL,
	Violation_Description varchar(100) NULL,
	Violation_Memo nvarchar(MAX) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (InspectionViolationsSK)
);


-- add constraints

ALTER TABLE dbo.FCT_Dallas_FoodInspection 
ADD CONSTRAINT fk_Dim_Dallas_Geo_FCT_Dallas_FoodInspection FOREIGN KEY (GeoSK)
REFERENCES dbo.Dim_Dallas_Geo (GeoSK);

ALTER TABLE dbo.FCT_Dallas_FoodInspection 
ADD CONSTRAINT fk_Dim_Dallas_InspectionType_FCT_Dallas_FoodInspection FOREIGN KEY (InspectionTypeSK)
REFERENCES dbo.Dim_Dallas_InspectionType (InspectionTypeSK);

ALTER TABLE dbo.FCT_Dallas_FoodInspection 
ADD CONSTRAINT fk_Dim_Dallas_Restaurant_FCT_Dallas_FoodInspection FOREIGN KEY (RestaurantSK)
REFERENCES dbo.Dim_Dallas_Restaurant (RestaurantSK);

ALTER TABLE dbo.FCT_Dallas_FoodInspection_Violations 
ADD CONSTRAINT fk_FCT_Dallas_FoodInspection_FCT_Dallas_FoodInspection_Violations FOREIGN KEY (InspectionSK)
REFERENCES dbo.FCT_Dallas_FoodInspection (InspectionSK);

