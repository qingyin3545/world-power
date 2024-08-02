
----本地城市规模人口产出加成
INSERT  INTO Building_YieldChangesPerPop(BuildingType,YieldType,Yield)VALUES
      ('BUILDING_CITY_SIZE_TOWN', 'YIELD_CRIME',25),
      ('BUILDING_CITY_SIZE_SMALL', 'YIELD_CRIME',25),
      ('BUILDING_CITY_SIZE_MEDIUM', 'YIELD_CRIME',25),
	  ('BUILDING_CITY_SIZE_LARGE', 'YIELD_CRIME',25),
      ('BUILDING_CITY_SIZE_XL', 'YIELD_CRIME',25),
	  ('BUILDING_CITY_SIZE_XXL', 'YIELD_CRIME',25),
	  ('BUILDING_CITY_SIZE_GLOBAL', 'YIELD_CRIME',25);


-----------------------------------------------------------------------------------------------------
---建筑与人口产出

CREATE TABLE IF NOT EXISTS BuildingClass_CrimeChangesPerPop (BuildingClassType TEXT DEFAULT NULL, Yield INTEGER DEFAULT 0);

INSERT INTO BuildingClass_CrimeChangesPerPop (BuildingClassType,	Yield)
SELECT 'BUILDINGCLASS_BARRACKS',		-5 UNION ALL   --兵营
SELECT 'BUILDINGCLASS_ARMORY',			-5 UNION ALL   --军械所
SELECT 'BUILDINGCLASS_MILITARY_BASE',	-5 UNION ALL   --军事基地
SELECT 'BUILDINGCLASS_DUNGEON',			-5 UNION ALL   --地牢
SELECT 'BUILDINGCLASS_CONSTABLE',		-5 UNION ALL   --治安署
SELECT 'BUILDINGCLASS_LOCKUP',			-5 UNION ALL   --监禁所
SELECT 'BUILDINGCLASS_COURTHOUSE',		-5 UNION ALL   --法院
SELECT 'BUILDINGCLASS_SHERIFF_OFFICE',	-5 UNION ALL   --审计署
SELECT 'BUILDINGCLASS_POLICE_STATION',	-5 UNION ALL  --警察局

SELECT 'BUILDINGCLASS_MARKET',			2 UNION ALL   --市场
SELECT 'BUILDINGCLASS_STOCK_EXCHANGE',	2 UNION ALL   --证券交易所
SELECT 'BUILDINGCLASS_BEVERAGE_FACTORY',2 UNION ALL   --酒吧
SELECT 'BUILDINGCLASS_FINANCE_COMPANY',	2 ;   --金融公司


INSERT INTO Building_YieldChangesPerPop(BuildingType, YieldType, Yield) 
SELECT	b.Type, 'YIELD_CRIME', h.Yield 
FROM Buildings AS b,  BuildingClass_CrimeChangesPerPop AS h
WHERE b.BuildingClass = h.BuildingClassType;


-----------------------------------------------------------------------------------------------------

INSERT INTO Building_BuildingClassYieldChanges (BuildingType, 	BuildingClassType, 	YieldType, YieldChange)
SELECT 	'BUILDING_BEILUN_TOWER', 	'BUILDINGCLASS_JAIL',	'YIELD_CRIME', 	-3 UNION ALL
SELECT 	'BUILDING_BEILUN_TOWER', 	'BUILDINGCLASS_DUNGEON',	'YIELD_CRIME', 	-3 UNION ALL
SELECT 	'BUILDING_BEILUN_TOWER', 	'BUILDINGCLASS_HARBOR',	'YIELD_CRIME', 	-3 UNION ALL

SELECT 	'BUILDING_ISHTARGATE', 	'BUILDINGCLASS_WALLS',	'YIELD_CRIME', 	-2 UNION ALL
SELECT 	'BUILDING_SPACE_FORTRESS', 	'BUILDINGCLASS_MILITARY_AIRBASE',	'YIELD_CRIME', 	-3 UNION ALL
SELECT 	'BUILDING_SPACE_FORTRESS', 	'BUILDINGCLASS_BIOMOD_TANK',	'YIELD_CRIME', 	-3 UNION ALL
SELECT 	'BUILDING_SPACE_FORTRESS', 	'BUILDINGCLASS_MISSILE_BASE',	'YIELD_CRIME', 	-3 UNION ALL
SELECT 	'BUILDING_SPACE_FORTRESS', 	'BUILDINGCLASS_DEFENSE_NETWORK',	'YIELD_CRIME', 	-3 UNION ALL
SELECT 	'BUILDING_SPACE_FORTRESS', 	'BUILDINGCLASS_NAVAL_BASE',	'YIELD_CRIME', 	-3 ;


-----------------------------------------------------------------------------------------------------
INSERT INTO Building_BuildingClassYieldModifiers(BuildingType, BuildingClassType,YieldType,Modifier) VALUES  
     ('BUILDING_CITADEL_OF_CARCASSONNE', 'BUILDINGCLASS_CASTLE', 'YIELD_CRIME',-3),
      ('BUILDING_CITADEL_OF_CARCASSONNE', 'BUILDINGCLASS_BASTION', 'YIELD_CRIME',-3),

	  ('BUILDING_KING_SOLOMON', 'BUILDINGCLASS_ACADEMY', 'YIELD_CRIME',-3),
      ('BUILDING_KING_SOLOMON', 'BUILDINGCLASS_LIBRARY', 'YIELD_CRIME',-3);

-----------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BuildingClass_CrimeModifiersGlobal (BuildingClassType TEXT DEFAULT NULL, Yield INTEGER DEFAULT 0);

INSERT INTO BuildingClass_CrimeModifiersGlobal (BuildingClassType,	Yield)
SELECT 'BUILDINGCLASS_KGB',			             -33 UNION ALL   --克格勃
SELECT 'BUILDINGCLASS_INTELLIGENCE_BUREAU',		-10 UNION ALL   --情报局
SELECT 'BUILDINGCLASS_BLETCHLEY_PARK',		-15 ;   --布莱 


---全局加成
INSERT INTO Building_GlobalYieldModifiers(BuildingType, YieldType, Yield) 
SELECT	b.Type, 'YIELD_CRIME', h.Yield 
FROM Buildings AS b,  BuildingClass_CrimeModifiersGlobal AS h
WHERE b.BuildingClass = h.BuildingClassType;

-----------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BuildingClass_CrimeModifiers (BuildingClassType TEXT DEFAULT NULL, Yield INTEGER DEFAULT 0);

INSERT INTO BuildingClass_CrimeModifiers (BuildingClassType,Yield)
SELECT 'BUILDINGCLASS_BARRACKS',		 -5 UNION ALL   --兵营
SELECT 'BUILDINGCLASS_ARMORY',			-5 UNION ALL   --军械所
SELECT 'BUILDINGCLASS_CASTLE',			-5 UNION ALL   --城堡
SELECT 'BUILDINGCLASS_ARSENAL',			-5 UNION ALL   --兵工厂
SELECT 'BUILDINGCLASS_MILITARY_BASE',	-10 UNION ALL   --军事基地
SELECT 'BUILDINGCLASS_XCOM_HEADQUARTERS',-15 UNION ALL   --XCOM
SELECT 'BUILDINGCLASS_BIOMOD_TANK',		-20 UNION ALL	--星际基地

SELECT 'BUILDINGCLASS_DUNGEON',			-5 UNION ALL   --地牢
SELECT 'BUILDINGCLASS_CONSTABLE',		-5 UNION ALL   --治安署
SELECT 'BUILDINGCLASS_ACADEMY',			-5 UNION ALL   --学院
SELECT 'BUILDINGCLASS_UNIVERSITY',		-5 UNION ALL   --大学
SELECT 'BUILDINGCLASS_OXFORD_UNIVERSITY',-5 UNION ALL   --牛津大学
SELECT 'BUILDINGCLASS_LOCKUP',			-5 UNION ALL   --监禁所
SELECT 'BUILDINGCLASS_PUBLIC_SCHOOL',	-4 UNION ALL   --公立学校
SELECT 'BUILDINGCLASS_SANKORE',			-5 UNION ALL   --桑科雷
SELECT 'BUILDINGCLASS_COURTHOUSE',		-5 UNION ALL   --法院
SELECT 'BUILDINGCLASS_SHERIFF_OFFICE',	-5 UNION ALL   --审计署
SELECT 'BUILDINGCLASS_POLICE_STATION',	-8 UNION ALL  --警察局

SELECT 'BUILDINGCLASS_GRANARY',			3 UNION ALL   --粮仓
SELECT 'BUILDINGCLASS_GRAIN_DEPOT',		3 UNION ALL   --粮库
SELECT 'BUILDINGCLASS_CARAVANSARY',		3 UNION ALL   --客栈

SELECT 'BUILDINGCLASS_STABLE',			3 UNION ALL   --马厩
SELECT 'BUILDINGCLASS_MARKET',			3 UNION ALL   --市场
SELECT 'BUILDINGCLASS_STOCK_EXCHANGE',	3 UNION ALL   --证券交易所
SELECT 'BUILDINGCLASS_BEVERAGE_FACTORY',3 UNION ALL   --酒吧
SELECT 'BUILDINGCLASS_FINANCE_COMPANY',	5 UNION ALL   --金融公司
SELECT 'BUILDINGCLASS_INTERNATIONAL_SEAPORT',5 UNION ALL   --国际港口
SELECT 'BUILDINGCLASS_AIRPORT',			5 UNION ALL   --机场
SELECT 'BUILDINGCLASS_INTERNATIONAL_AIRPORT',5 UNION ALL   --国际机场

SELECT 'BUILDINGCLASS_PALACE',		  -25 UNION ALL
SELECT 'BUILDINGCLASS_CITY_HALL_LV1', -15 UNION ALL    --一级
SELECT 'BUILDINGCLASS_CITY_HALL_LV2', -10 UNION ALL	--二级
SELECT 'BUILDINGCLASS_CITY_HALL_LV3',5 UNION ALL	--三级
SELECT 'BUILDINGCLASS_CITY_HALL_LV4',25 UNION ALL    --四级
SELECT 'BUILDINGCLASS_CITY_HALL_LV5',40 UNION ALL	--五级

SELECT 'BUILDINGCLASS_CITY_SIZE_SMALL',	 6 UNION ALL    --小城市
SELECT 'BUILDINGCLASS_CITY_SIZE_MEDIUM',6 UNION ALL	--中城市
SELECT 'BUILDINGCLASS_CITY_SIZE_LARGE',	10 UNION ALL	--大城市
SELECT 'BUILDINGCLASS_CITY_SIZE_XL',	10 UNION ALL    --特大城市
SELECT 'BUILDINGCLASS_CITY_SIZE_XXL',	15 UNION ALL	--巨型城市
SELECT 'BUILDINGCLASS_CITY_SIZE_GLOBAL',20 ;	--大都会

---本地加成
INSERT INTO  Building_YieldModifiers(BuildingType, YieldType, Yield) 
SELECT	b.Type, 'YIELD_CRIME', h.Yield 
FROM Buildings AS b,  BuildingClass_CrimeModifiers AS h
WHERE b.BuildingClass = h.BuildingClassType;


-----------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BuildingClass_CrimeYields (BuildingClassType TEXT DEFAULT NULL, Yield INTEGER DEFAULT 0);

INSERT INTO BuildingClass_CrimeYields (BuildingClassType,	Yield)
SELECT 'BUILDINGCLASS_LIBRARY',			 -2 UNION ALL   --图书馆
SELECT 'BUILDINGCLASS_BARRACKS',			 -2 UNION ALL   --兵营
SELECT 'BUILDINGCLASS_ARMORY',				-2 UNION ALL   --军械所
SELECT 'BUILDINGCLASS_CASTLE',				 -5 UNION ALL   --城堡
SELECT 'BUILDINGCLASS_ARSENAL',			        -5 UNION ALL   --兵工厂
SELECT 'BUILDINGCLASS_MILITARY_BASE',			-10 UNION ALL   --军事基地
SELECT 'BUILDINGCLASS_MILITARY_ACADEMY',	       -7 UNION ALL   --军事学院
SELECT 'BUILDINGCLASS_XCOM_HEADQUARTERS',		-6 UNION ALL   --XCOM
SELECT 'BUILDINGCLASS_BIOMOD_TANK',			   -8 UNION ALL	--星际基地
SELECT 'BUILDINGCLASS_BASTION',				 -5 UNION ALL   --棱堡

SELECT 'BUILDINGCLASS_FASIL_GHEBBI',	-7 UNION ALL   --法西尔盖比 
SELECT 'BUILDINGCLASS_KRAK_DES_CHEVALIERS',	-7 UNION ALL   --骑士堡 
SELECT 'BUILDINGCLASS_CITADEL_OF_CARCASSONNE',	-7 UNION ALL   --卡尔卡松  
SELECT 'BUILDINGCLASS_ISHTARGATE',			-10 UNION ALL   --伊斯塔尔门 
SELECT 'BUILDINGCLASS_HAGIA_SOPHIA',			-3 UNION ALL   --圣索非亚
SELECT 'BUILDINGCLASS_BOROBUDUR',				-3 UNION ALL   --婆罗浮屠

SELECT 'BUILDINGCLASS_OSARAGI',					-15 UNION ALL   --高德院
SELECT 'BUILDINGCLASS_DUNGEON',					-5 UNION ALL   --地牢
SELECT 'BUILDINGCLASS_CONSTABLE',				-5 UNION ALL   --治安署
SELECT 'BUILDINGCLASS_ACADEMY',					-2 UNION ALL   --学院
SELECT 'BUILDINGCLASS_UNIVERSITY',				-2 UNION ALL   --大学
SELECT 'BUILDINGCLASS_OXFORD_UNIVERSITY',		-3 UNION ALL   --牛津大学
SELECT 'BUILDINGCLASS_BANK',					3 UNION ALL   --银行
SELECT 'BUILDINGCLASS_LOCKUP',					-5 UNION ALL   --监禁所
SELECT 'BUILDINGCLASS_COURTHOUSE',				-5 UNION ALL   --法院
SELECT 'BUILDINGCLASS_PUBLIC_SCHOOL',			-4 UNION ALL   --公立学校
SELECT 'BUILDINGCLASS_SANKORE',			        -5 UNION ALL   --桑科雷

SELECT 'BUILDINGCLASS_SHERIFF_OFFICE',			-8 UNION ALL   --审计署
SELECT 'BUILDINGCLASS_POLICE_STATION',			-8 UNION ALL   --警察局

SELECT 'BUILDINGCLASS_KGB',			             -30 UNION ALL   --克格勃
SELECT 'BUILDINGCLASS_INTELLIGENCE_BUREAU',		-10 UNION ALL   --情报局
SELECT 'BUILDINGCLASS_PROCURATORATE',		-10 UNION ALL   --地检署

SELECT 'BUILDINGCLASS_GRANARY',				     1 UNION ALL   --粮仓
SELECT 'BUILDINGCLASS_GRAIN_DEPOT',			    2 UNION ALL   --粮库
SELECT 'BUILDINGCLASS_CARAVANSARY',				2 UNION ALL   --客栈

SELECT 'BUILDINGCLASS_STABLE',				    2 UNION ALL   --马厩
SELECT 'BUILDINGCLASS_MARKET',				     3 UNION ALL   --市场
SELECT 'BUILDINGCLASS_STOCK_EXCHANGE',			 3 UNION ALL   --证券交易所
SELECT 'BUILDINGCLASS_BEVERAGE_FACTORY',		3 UNION ALL   --酒吧
SELECT 'BUILDINGCLASS_FINANCE_COMPANY',		    4 UNION ALL   --金融公司
SELECT 'BUILDINGCLASS_INTERNATIONAL_SEAPORT',	4 UNION ALL   --国际港口
SELECT 'BUILDINGCLASS_AIRPORT',					4 UNION ALL   --机场
SELECT 'BUILDINGCLASS_INTERNATIONAL_AIRPORT',	6 UNION ALL   --国际机场
SELECT 'BUILDINGCLASS_NAVAL_BASE',				-10 UNION ALL   --海军基地
SELECT 'BUILDINGCLASS_GREAT_FIREWALL',			-10 UNION ALL   --防火墙
SELECT 'BUILDINGCLASS_LIBERATION_GATE',		    20 UNION ALL   --解放门

SELECT 'BUILDINGCLASS_UNDERGROUND',			    4 UNION ALL	--地下城市
SELECT 'BUILDINGCLASS_SKYNET',				    -40 UNION ALL     --天网
SELECT 'BUILDINGCLASS_MARKOV',				    10 UNION ALL     --马尔科夫 
SELECT 'BUILDINGCLASS_GREAT_LIBRARY',			 -5 UNION ALL     --大图
SELECT 'BUILDINGCLASS_JURASSIC_PARK',			10  UNION ALL	  --异种


SELECT 'BUILDINGCLASS_PALACE',			        -10 UNION ALL
SELECT 'BUILDINGCLASS_CITY_HALL_LV1',			-6 UNION ALL
SELECT 'BUILDINGCLASS_CITY_HALL_LV2',			-3 UNION ALL
SELECT 'BUILDINGCLASS_CITY_HALL_LV3',			3 UNION ALL
SELECT 'BUILDINGCLASS_CITY_HALL_LV4',			6 UNION ALL
SELECT 'BUILDINGCLASS_CITY_HALL_LV5',			10 UNION ALL

SELECT 'BUILDINGCLASS_CITY_SIZE_SMALL',			5 UNION ALL	
SELECT 'BUILDINGCLASS_CITY_SIZE_MEDIUM',		5 UNION ALL	
SELECT 'BUILDINGCLASS_CITY_SIZE_LARGE',			10 UNION ALL
SELECT 'BUILDINGCLASS_CITY_SIZE_XL',			10 UNION ALL
SELECT 'BUILDINGCLASS_CITY_SIZE_XXL',			15 UNION ALL	
SELECT 'BUILDINGCLASS_CITY_SIZE_GLOBAL',		15 ; 


---犯罪点数
INSERT INTO Building_YieldChanges (BuildingType, YieldType, Yield) 
SELECT	b.Type, 'YIELD_CRIME', h.Yield 
FROM Buildings AS b, BuildingClass_CrimeYields AS h
WHERE b.BuildingClass = h.BuildingClassType;



UPDATE LocalizedText
	SET Text = Text||'[NEWLINE][NEWLINE][ICON_BULLET]-6[ICON_CRIME]犯罪率,-15%[ICON_CRIME]犯罪率。'
	WHERE Tag IN (SELECT Help FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_CITY_HALL_LV1');

UPDATE LocalizedText
	SET Text = Text||'[NEWLINE][NEWLINE][ICON_BULLET]-3[ICON_CRIME]犯罪率,-10%[ICON_CRIME]犯罪率。'
	WHERE Tag IN (SELECT Help FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_CITY_HALL_LV2');

UPDATE LocalizedText
	SET Text = Text||'[NEWLINE][NEWLINE][ICON_BULLET]+3[ICON_CRIME]犯罪率,+5%[ICON_CRIME]犯罪率。'
	WHERE Tag IN (SELECT Help FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_CITY_HALL_LV3');

UPDATE LocalizedText
	SET Text = Text||'[NEWLINE][NEWLINE][ICON_BULLET]+6[ICON_CRIME]犯罪率,+25%[ICON_CRIME]犯罪率。'
	WHERE Tag IN (SELECT Help FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_CITY_HALL_LV4');

UPDATE LocalizedText
	SET Text = Text||'[NEWLINE][NEWLINE][ICON_BULLET]+10[ICON_CRIME]犯罪率,+40%[ICON_CRIME]犯罪率。'
	WHERE Tag IN (SELECT Help FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_CITY_HALL_LV5');