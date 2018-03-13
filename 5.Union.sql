ALTER PROCEDURE pMDL_NPP_Output
(
	@CodPais CHAR(2),
	@AnioCampana VARCHAR(6)
)
AS
BEGIN 
/*
	SP: Modelo No Pase Pedido Data 
	Creado por: Johnny Valenzuela
	Fecha Creacion: 

	/*
	 Tiempo Inicial:
	 Tiempo Final: 
	*/
	

*/
	DECLARE @CodPais CHAR(6)
	DECLARE @AnioCampana VARCHAR(6)

	SET @AnioCampana = '201712'
	SET @CodPais = 'CO'

	DECLARE @AnioCampana_2 VARCHAR(6)
	SET @AnioCampana_2 = dbo.CalculaAnioCampana(@AnioCampana,-2)

	----1. Generamos Data Target --4seg
	EXEC KR_MATRIZ_TARG_V1 @CodPais, @AnioCampana;

	--2. Generamos Data De Consultora --2:30 min
	EXEC KR_MATRIZ_CONS_V1 @CodPais, @AnioCampana_2;

	--3. Generamos Data de Venta --6:30 min
	EXEC KR_MATRIZ_VEN_V1 @CodPais, @AnioCampana_2;

	--4 Generamos Data de Marca-Categoria --6:30 min
	EXEC KR_MATRIZ_VEN_MCT_V1 @CodPais, @AnioCampana_2;
	
	INSERT INTO BD_ANALITICO.dbo.MDL_MatrizNPP_Input 

	SELECT A.AnioCampanaUC as AnioCampana,
			A.CodPais, 
			A.PkEbelista,
			--B.Constancia_UC as Constancia,--????			
			--Cx_Activa as FlagActiva,--????
			--B.FlagIpUnico_UC as FlagIpUnicoZona,--????
			--Cx_PasoPedido as FlagPasoPedido,
			--Cx_Comp_Rolling as DesNivelComportamiento,
			--Cx_Status as DesStatusCorp,
			CASE A.Tipo WHEN 'Establecidas' THEN 0 ELSE 1 END AS Consultora_Nueva,
			A.[Target],
			B.R_GEN,
			B.Ant_Camp_Ingreso,
			B.antig_act1,
			B.antig_act2,
			B.Porc_camp,
			B.Porc_camp1,
			B.N_Camp_UlPedWeb,
			B.N_Camp_UlPed,
			B.N_Camp,
			B.Tipo_se_exit,
			B.Tipo_se_nivel,
			B.Tipo_se_est,
			B.Cod_Status_UC,
			--B.Constancia_UC,
			B.FlagIpUnico_UC,
			B.Comp_Rolling_UC,
			B.FlagPasoPedido_UC,
			B.Pc_Status_Corp_Norm_3C,
			B.Pc_Status_Corp_Norm_4C,
			B.Pc_Status_Corp_Norm_5C,
			B.Pc_Status_Corp_Norm_6C,
			B.Pc_Status_Corp_Norm_9C,
			B.Pc_Status_Corp_Norm_12C,
			B.Pc_Status_Corp_Norm_15C,
			B.Pc_Status_Corp_Norm_18C,
			B.Pc_Status_Corp_Reingreso_3C,
			B.Pc_Status_Corp_Reingreso_4C,
			B.Pc_Status_Corp_Reingreso_5C,
			B.Pc_Status_Corp_Reingreso_6C,
			B.Pc_Status_Corp_Reingreso_9C,
			B.Pc_Status_Corp_Reingreso_12C,
			B.Pc_Status_Corp_Reingreso_15C,
			B.Pc_Status_Corp_Reingreso_18C,
			B.Pc_Status_Corp_Retirada_3C,
			B.Pc_Status_Corp_Retirada_4C,
			B.Pc_Status_Corp_Retirada_5C,
			B.Pc_Status_Corp_Retirada_6C,
			B.Pc_Status_Corp_Retirada_9C,
			B.Pc_Status_Corp_Retirada_12C,
			B.Pc_Status_Corp_Retirada_15C,
			B.Pc_Status_Corp_Retirada_18C,
			B.Pc_Status_Corp_Egresada_3C,
			B.Pc_Status_Corp_Egresada_4C,
			B.Pc_Status_Corp_Egresada_5C,
			B.Pc_Status_Corp_Egresada_6C,
			B.Pc_Status_Corp_Egresada_9C,
			B.Pc_Status_Corp_Egresada_12C,
			B.Pc_Status_Corp_Egresada_15C,
			B.Pc_Status_Corp_Egresada_18C,
			--B.FlagTipoRolling_uc,
			B.Pc_tipo_rolling_3C,
			B.Pc_tipo_rolling_4C,
			B.Pc_tipo_rolling_5C,
			B.Pc_tipo_rolling_6C,
			B.Pc_tipo_rolling_9C,
			B.Pc_tipo_rolling_12C,
			B.Pc_tipo_rolling_15C,
			B.Pc_tipo_rolling_18C,
			B.Pc_Rolling_CONSTANTE_2_3C,
			B.Pc_Rolling_CONSTANTE_2_4C,
			B.Pc_Rolling_CONSTANTE_2_5C,
			B.Pc_Rolling_CONSTANTE_2_6C,
			B.Pc_Rolling_CONSTANTE_2_9C,
			B.Pc_Rolling_CONSTANTE_2_12C,
			B.Pc_Rolling_CONSTANTE_2_15C,
			B.Pc_Rolling_CONSTANTE_2_18C,
			B.Pc_Rolling_CONSTANTE_3_3C,
			B.Pc_Rolling_CONSTANTE_3_4C,
			B.Pc_Rolling_CONSTANTE_3_5C,
			B.Pc_Rolling_CONSTANTE_3_6C,
			B.Pc_Rolling_CONSTANTE_3_9C,
			B.Pc_Rolling_CONSTANTE_3_12C,
			B.Pc_Rolling_CONSTANTE_3_15C,
			B.Pc_Rolling_CONSTANTE_3_18C,
			B.Pc_Rolling_INCONSTANTES_3C,
			B.Pc_Rolling_INCONSTANTES_4C,
			B.Pc_Rolling_INCONSTANTES_5C,
			B.Pc_Rolling_INCONSTANTES_6C,
			B.Pc_Rolling_INCONSTANTES_9C,
			B.Pc_Rolling_INCONSTANTES_12C,
			B.Pc_Rolling_INCONSTANTES_15C,
			B.Pc_Rolling_INCONSTANTES_18C,
			--B.PC_Constancia_new_3C,
			--B.PC_Constancia_new_4C,
			--B.PC_Constancia_new_5C,
			--B.Pc_constancia_new_6C,
			--B.Pc_Inconstancia_new_3C ,
			--B.Pc_Inconstancia_new_4C ,
			--B.Pc_Inconstancia_new_5C ,
			--B.Pc_Inconstancia_new_6C ,
			B.FlagNoPasoPedido_3C ,
			B.FlagNoPasoPedido_4C ,
			B.FlagNoPasoPedido_5C ,
			B.FlagNoPasoPedido_6C ,
			B.FlagNoPasoPedido_9C ,
			B.FlagNoPasoPedido_12C,
			B.FlagNoPasoPedido_15C,
			B.FlagNoPasoPedido_18C,
			B.N_Camp_No_Paso_Pedido_3C	,
			B.N_Camp_No_Paso_Pedido_4C	,
			B.N_Camp_No_Paso_Pedido_5C	,
			B.N_Camp_No_Paso_Pedido_6C	,
			B.N_Camp_No_Paso_Pedido_9C	,
			B.N_Camp_No_Paso_Pedido_12C	,
			B.N_Camp_No_Paso_Pedido_15C	,
			B.N_Camp_No_Paso_Pedido_18C	,
			B.Pc_No_Paso_Pedido_3C		,
			B.Pc_No_Paso_Pedido_4C		,
			B.Pc_No_Paso_Pedido_5C		,
			B.Pc_No_Paso_Pedido_6C		,
			B.Pc_No_Paso_Pedido_9C		,
			B.Pc_No_Paso_Pedido_12C		,
			B.Pc_No_Paso_Pedido_15C		,
			B.Pc_No_Paso_Pedido_18C		,
			B.N_Inactiva_3C		,
			B.N_Inactiva_4C		,
			B.N_Inactiva_5C		,
			B.N_Inactiva_6C		,
			B.N_Inactiva_9C		,
			B.N_Inactiva_12C	,
			B.N_Inactiva_15C	,
			B.N_Inactiva_18C	,
			B.Pc_Inactiva_3C	,
			B.Pc_Inactiva_4C	,
			B.Pc_Inactiva_5C	,
			B.Pc_Inactiva_6C	,
			B.Pc_Inactiva_9C	,
			B.Pc_Inactiva_12C	,
			B.Pc_Inactiva_15C	,
			B.Pc_Inactiva_18C	,
			B.FlagIPUnico_3C	,
			B.FlagIPUnico_4C	,
			B.FlagIPUnico_5C	,
			B.FlagIPUnico_6C	,
			B.FlagIPUnico_9C	,
			B.FlagIPUnico_12C	,
			B.FlagIPUnico_15C	,
			B.FlagIPUnico_18C	,
			B.Pc_Ipunico_3C		,
			B.Pc_Ipunico_4C		,
			B.Pc_Ipunico_5C		,
			B.Pc_Ipunico_6C		,
			B.Pc_Ipunico_9C		,
			B.Pc_Ipunico_12C	,
			B.Pc_Ipunico_15C	,
			B.Pc_Ipunico_18C	,
			CAST(NULL AS INT) AS N_Camp_ent_Inc,
			CAST(NULL AS INT) AS N_Incentivo_UC,
			CAST(NULL AS INT) AS N_Incentivo_U2C,
			CAST(NULL AS INT) AS N_Incentivo_U3C,
			CAST(NULL AS INT) AS N_Incentivo_U4C,
			CAST(NULL AS INT) AS N_Incentivo_U5C,
			CAST(NULL AS INT) AS N_Incentivo_U6C,
			CAST(NULL AS INT) AS N_Incentivo_U7C,
			CAST(NULL AS INT) AS N_Incentivo_U8C,
			CAST(NULL AS INT) AS N_Incentivo_U9C,
			CAST(NULL AS INT) AS N_Incentivo_U10C,
			CAST(NULL AS INT) AS N_Incentivo_U11C,
			CAST(NULL AS INT) AS N_Incentivo_U12C,
			CAST(NULL AS INT) AS N_Incentivo_U13C,
			CAST(NULL AS INT) AS N_Incentivo_U14C,
			CAST(NULL AS INT) AS N_Incentivo_U15C,
			CAST(NULL AS INT) AS N_Incentivo_U16C,
			CAST(NULL AS INT) AS N_Incentivo_U17C,
			CAST(NULL AS INT) AS N_Incentivo_U18C,
			CAST(NULL AS INT) AS FLAG_Incentivo_UC,
			CAST(NULL AS INT) AS FLAG_Incentivo_U2C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U3C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U4C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U5C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U6C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U7C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U8C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U9C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U10C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U11C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U12C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U13C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U14C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U15C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U16C,
			CAST(NULL AS INT) AS FLAG_Incentivo_U17C,
			CAST(NULL AS INT) AS Pc_Incentivo_18C,
			CAST(NULL AS INT) AS Pc_Incentivo_17C,
			CAST(NULL AS INT) AS Pc_Incentivo_16C,
			CAST(NULL AS INT) AS Pc_Incentivo_15C,
			CAST(NULL AS INT) AS Pc_Incentivo_14C,
			CAST(NULL AS INT) AS Pc_Incentivo_13C,
			CAST(NULL AS INT) AS Pc_Incentivo_12C,
			CAST(NULL AS INT) AS Pc_Incentivo_11C,
			CAST(NULL AS INT) AS Pc_Incentivo_10C,
			CAST(NULL AS INT) AS Pc_Incentivo_9C,
			CAST(NULL AS INT) AS Pc_Incentivo_8C,
			CAST(NULL AS INT) AS Pc_Incentivo_7C,
			CAST(NULL AS INT) AS Pc_Incentivo_6C,
			CAST(NULL AS INT) AS Pc_Incentivo_5C,
			CAST(NULL AS INT) AS Pc_Incentivo_4C,
			CAST(NULL AS INT) AS Pc_Incentivo_3C,
			CAST(NULL AS INT) AS Pc_Incentivo_2C,
			C.UC_RealUUVendidas					,
			C.U2C_RealUUVendidas				,
			C.U3C_RealUUVendidas				,
			C.U4C_RealUUVendidas				,
			C.U5C_RealUUVendidas				,
			C.U6C_RealUUVendidas				,
			C.U9C_RealUUVendidas				,
			C.U12C_RealUUVendidas				,
			C.U15C_RealUUVendidas				,
			C.U18C_RealUUVendidas				,
			C.UC_RealUUFaltantes				,
			C.U2C_RealUUFaltantes				,
			C.U3C_RealUUFaltantes				,
			C.U4C_RealUUFaltantes				,
			C.U5C_RealUUFaltantes				,
			C.U6C_RealUUFaltantes				,
			C.U9C_RealUUFaltantes				,
			C.U12C_RealUUFaltantes				,
			C.U15C_RealUUFaltantes				,
			C.U18C_RealUUFaltantes				,
			--C.UC_RealUUDevueltas				,
			--C.U2C_RealUUDevueltas				,
			--C.U3C_RealUUDevueltas				,
			--C.U4C_RealUUDevueltas				,
			--C.U5C_RealUUDevueltas				,
			--C.U6C_RealUUDevueltas				,
			--C.U9C_RealUUDevueltas				,
			--C.U12C_RealUUDevueltas				,
			--C.U15C_RealUUDevueltas				,
			--C.U18C_RealUUDevueltas				,
			C.UC_RealUUAnuladas					,
			C.U2C_RealUUAnuladas				,
			C.U3C_RealUUAnuladas				,
			C.U4C_RealUUAnuladas				,
			C.U5C_RealUUAnuladas				,
			C.U6C_RealUUAnuladas				,
			C.U9C_RealUUAnuladas				,
			C.U12C_RealUUAnuladas				,
			C.U15C_RealUUAnuladas				,
			C.U18C_RealUUAnuladas				,
			C.UC_RealVtaMNNeto					,
			C.U2C_RealVtaMNNeto					,
			C.U3C_RealVtaMNNeto					,
			C.U4C_RealVtaMNNeto					,
			C.U5C_RealVtaMNNeto					,
			C.U6C_RealVtaMNNeto					,
			C.U9C_RealVtaMNNeto					,
			C.U12C_RealVtaMNNeto				,
			C.U15C_RealVtaMNNeto				,
			C.U18C_RealVtaMNNeto				,
			C.UC_OportunidadAhorroMN			,
			C.U2C_OportunidadAhorroMN			,
			C.U3C_OportunidadAhorroMN			,
			C.U4C_OportunidadAhorroMN			,
			C.U5C_OportunidadAhorroMN			,
			C.U6C_OportunidadAhorroMN			,
			C.U9C_OportunidadAhorroMN			,
			C.U12C_OportunidadAhorroMN			,
			C.U15C_OportunidadAhorroMN			,
			C.U18C_OportunidadAhorroMN			,
			C.U2C_PRO_RealVtaMNNeto				,
			C.U2C_PRO_OportunidadAhorroMN		,
			C.U2C_DESV_RealUUVendidas			,
			--C.U2C_DESV_RealUUDevueltas			,
			C.U2C_DESV_RealUUAnuladas			,
			C.U2C_DESV_RealVtaMNNeto			,
			C.U2C_MIN_RealUUVendidas			,
			--C.U2C_MIN_RealUUDevueltas			,
			C.U2C_MIN_RealUUAnuladas			,
			C.U2C_MIN_RealVtaMNNeto				,
			C.U2C_MAX_RealUUVendidas			,
			--C.U2C_MAX_RealUUDevueltas			,
			C.U2C_MAX_RealUUAnuladas			,
			C.U2C_MAX_RealVtaMNNeto				,
			C.U3C_PRO_RealVtaMNNeto				,
			C.U3C_PRO_OportunidadAhorroMN		,
			C.U3C_DESV_RealUUVendidas			,
			--C.U3C_DESV_RealUUDevueltas			,
			C.U3C_DESV_RealUUAnuladas			,
			C.U3C_DESV_RealVtaMNNeto			,
			C.U3C_MIN_RealUUVendidas			,
			--C.U3C_MIN_RealUUDevueltas			,
			C.U3C_MIN_RealUUAnuladas			,
			C.U3C_MIN_RealVtaMNNeto				,
			C.U3C_MAX_RealUUVendidas			,
			--C.U3C_MAX_RealUUDevueltas			,
			C.U3C_MAX_RealUUAnuladas			,
			C.U3C_MAX_RealVtaMNNeto				,
			C.U4C_PRO_RealVtaMNNeto				,
			C.U4C_PRO_OportunidadAhorroMN		,
			C.U4C_DESV_RealUUVendidas			,
			--C.U4C_DESV_RealUUDevueltas			,
			C.U4C_DESV_RealUUAnuladas			,
			C.U4C_DESV_RealVtaMNNeto			,
			C.U4C_MIN_RealUUVendidas			,
			--C.U4C_MIN_RealUUDevueltas			,
			C.U4C_MIN_RealUUAnuladas			,
			C.U4C_MIN_RealVtaMNNeto				,
			C.U4C_MAX_RealUUVendidas			,
			--C.U4C_MAX_RealUUDevueltas			,
			C.U4C_MAX_RealUUAnuladas			,
			C.U4C_MAX_RealVtaMNNeto				,
			C.U5C_PRO_RealVtaMNNeto				,
			C.U5C_PRO_OportunidadAhorroMN		,
			C.U5C_DESV_RealUUVendidas			,
			--C.U5C_DESV_RealUUDevueltas			,
			C.U5C_DESV_RealUUAnuladas			,
			C.U5C_DESV_RealVtaMNNeto			,
			C.U5C_MIN_RealUUVendidas			,
			--C.U5C_MIN_RealUUDevueltas			,
			C.U5C_MIN_RealUUAnuladas			,
			C.U5C_MIN_RealVtaMNNeto				,
			C.U5C_MAX_RealUUVendidas			,
			--C.U5C_MAX_RealUUDevueltas			,
			C.U5C_MAX_RealUUAnuladas			,
			C.U5C_MAX_RealVtaMNNeto				,
			C.U6C_PRO_RealVtaMNNeto				,
			C.U6C_PRO_OportunidadAhorroMN		,
			C.U6C_DESV_RealUUVendidas			,
			--C.U6C_DESV_RealUUDevueltas			,
			C.U6C_DESV_RealUUAnuladas			,
			C.U6C_DESV_RealVtaMNNeto			,
			C.U6C_MIN_RealUUVendidas			,
			--C.U6C_MIN_RealUUDevueltas			,
			C.U6C_MIN_RealUUAnuladas			,
			C.U6C_MIN_RealVtaMNNeto				,
			C.U6C_MAX_RealUUVendidas			,
			--C.U6C_MAX_RealUUDevueltas			,
			C.U6C_MAX_RealUUAnuladas			,
			C.U6C_MAX_RealVtaMNNeto				,
			C.U9C_PRO_RealVtaMNNeto				,
			C.U9C_PRO_OportunidadAhorroMN		,
			C.U9C_DESV_RealUUVendidas			,
			--C.U9C_DESV_RealUUDevueltas			,
			C.U9C_DESV_RealUUAnuladas			,
			C.U9C_DESV_RealVtaMNNeto			,
			C.U9C_MIN_RealUUVendidas			,
			--C.U9C_MIN_RealUUDevueltas			,
			C.U9C_MIN_RealUUAnuladas			,
			C.U9C_MIN_RealVtaMNNeto				,
			C.U9C_MAX_RealUUVendidas			,
			--C.U9C_MAX_RealUUDevueltas			,
			C.U9C_MAX_RealUUAnuladas			,
			C.U9C_MAX_RealVtaMNNeto				,
			C.U12C_PRO_RealVtaMNNeto			,
			C.U12C_PRO_OportunidadAhorroMN		,
			C.U12C_DESV_RealUUVendidas			,
			--C.U12C_DESV_RealUUDevueltas			,
			C.U12C_DESV_RealUUAnuladas			,
			C.U12C_DESV_RealVtaMNNeto			,
			C.U12C_MIN_RealUUVendidas			,
			--C.U12C_MIN_RealUUDevueltas			,
			C.U12C_MIN_RealUUAnuladas			,
			C.U12C_MIN_RealVtaMNNeto			,
			C.U12C_MAX_RealUUVendidas			,
			--C.U12C_MAX_RealUUDevueltas			,
			C.U12C_MAX_RealUUAnuladas			,
			C.U12C_MAX_RealVtaMNNeto			,
			C.U15C_PRO_RealVtaMNNeto			,
			C.U15C_PRO_OportunidadAhorroMN		,
			C.U15C_DESV_RealUUVendidas			,
			--C.U15C_DESV_RealUUDevueltas			,
			C.U15C_DESV_RealUUAnuladas			,
			C.U15C_DESV_RealVtaMNNeto			,
			C.U15C_MIN_RealUUVendidas			,
			--C.U15C_MIN_RealUUDevueltas			,
			C.U15C_MIN_RealUUAnuladas			,
			C.U15C_MIN_RealVtaMNNeto			,
			C.U15C_MAX_RealUUVendidas			,
			--C.U15C_MAX_RealUUDevueltas			,
			C.U15C_MAX_RealUUAnuladas			,
			C.U15C_MAX_RealVtaMNNeto			,
			C.U18C_PRO_RealVtaMNNeto			,
			C.U18C_PRO_OportunidadAhorroMN		,
			C.U18C_DESV_RealUUVendidas			,
			--C.U18C_DESV_RealUUDevueltas			,
			C.U18C_DESV_RealUUAnuladas			,
			C.U18C_DESV_RealVtaMNNeto			,
			C.U18C_MIN_RealUUVendidas			,
			--C.U18C_MIN_RealUUDevueltas			,
			C.U18C_MIN_RealUUAnuladas			,
			C.U18C_MIN_RealVtaMNNeto			,
			C.U18C_MAX_RealUUVendidas			,
			--C.U18C_MAX_RealUUDevueltas			,
			C.U18C_MAX_RealUUAnuladas			,
			C.U18C_MAX_RealVtaMNNeto			,
			C.U2C_DESV_OportunidadAhorroMN		,
			C.U2C_MIN_OportunidadAhorroMN		,
			C.U2C_MAX_OportunidadAhorroMN		,
			C.U3C_DESV_OportunidadAhorroMN		,
			C.U3C_MIN_OportunidadAhorroMN		,
			C.U3C_MAX_OportunidadAhorroMN		,
			C.U4C_DESV_OportunidadAhorroMN		,
			C.U4C_MIN_OportunidadAhorroMN		,
			C.U4C_MAX_OportunidadAhorroMN		,
			C.U5C_DESV_OportunidadAhorroMN		,
			C.U5C_MIN_OportunidadAhorroMN		,
			C.U5C_MAX_OportunidadAhorroMN		,
			C.U6C_DESV_OportunidadAhorroMN		,
			C.U6C_MIN_OportunidadAhorroMN		,
			C.U6C_MAX_OportunidadAhorroMN		,
			C.U9C_DESV_OportunidadAhorroMN		,
			C.U9C_MIN_OportunidadAhorroMN		,
			C.U9C_MAX_OportunidadAhorroMN		,
			C.U12C_DESV_OportunidadAhorroMN		,
			C.U12C_MIN_OportunidadAhorroMN		,
			C.U12C_MAX_OportunidadAhorroMN		,
			C.U15C_DESV_OportunidadAhorroMN		,
			C.U15C_MIN_OportunidadAhorroMN		,
			C.U15C_MAX_OportunidadAhorroMN		,
			C.U18C_DESV_OportunidadAhorroMN		,
			C.U18C_MIN_OportunidadAhorroMN		,
			C.U18C_MAX_OportunidadAhorroMN		,
			C.Rat1								,
			C.Rat2								,
			C.Rat3								,
			C.Rat4								,
			C.Rat5								,
			C.Rat6								,
			C.Rat7								,
			C.Rat8								,
			C.Rat9								,
			C.Rat10								,
			C.Rat11								,
			C.Rat12								,
			C.Rat13								,
			C.Rat14								,
			C.Rat15								,
			C.Rat16								,
			C.Rat17								,
			C.Rat18								,
			C.Rat19								,
			C.Rat20								,
			C.Rat21								,
			C.Rat22								,
			C.Rat23								,
			C.Rat24								,
			C.Rat25								,
			C.Rat26								,
			C.Rat27								,
			C.Rat28								,
			C.Rat29								,
			C.Rat30								,
			C.Rat31								,
			C.Rat32								,
			C.Rat33								,
			C.Rat34								,
			C.Rat35								,
			C.Rat36								,
			C.Rat37								,
			C.Rat38								,
			C.Rat39								,
			C.Rat40								,
			C.Rat41								,
			C.Rat42								,
			C.Rat43								,
			C.Rat44								,
			C.Rat45								,
			C.Rat46								,
			C.TEND_UVEN_U2C						,
			C.TEND_UVEN_U3C						,
			C.TEND_UVEN_U4C						,
			C.TEND_UVEN_U5C						,
			C.TEND_UVEN_U6C						,
			C.TEND_UVEN_U9C						,
			C.TEND_UVEN_U12C					,
			C.TEND_UVEN_U15C					,
			C.TEND_UVEN_U18C					,
			C.TEND_TRI_UVEN_U6C					,
			C.TEND_TRI_UVEN_U9C					,
			C.TEND_TRI_UVEN_U12C				,
			C.TEND_TRI_UVEN_U15C				,
			C.TEND_TRI_UVEN_U18C				,
			C.TEND_AHORR_U2C					,
			C.TEND_AHORR_U3C					,
			C.TEND_AHORR_U4C					,
			C.TEND_AHORR_U5C					,
			C.TEND_AHORR_U6C					,
			C.TEND_AHORR_U9C					,
			C.TEND_AHORR_U12C					,
			C.TEND_AHORR_U15C					,
			C.TEND_AHORR_U18C					,
			C.TEND_TRI_AHORR_U6C				,
			C.TEND_TRI_AHORR_U9C				,
			C.TEND_TRI_AHORR_U12C				,
			C.TEND_TRI_AHORR_U15C				,
			C.TEND_TRI_AHORR_U18C				,
			C.TEND_VTA_U2C						,
			C.TEND_VTA_U3C						,
			C.TEND_VTA_U4C						,
			C.TEND_VTA_U5C						,
			C.TEND_VTA_U6C						,
			C.TEND_VTA_U9C						,
			C.TEND_VTA_U12C						,
			C.TEND_VTA_U15C						,
			C.TEND_VTA_U18C						,
			C.TEND_TRI_VTA_U6C					,
			C.TEND_TRI_VTA_U9C					,
			C.TEND_TRI_VTA_U12C					,
			C.TEND_TRI_VTA_U15C					,
			C.TEND_TRI_VTA_U18C					,
			C.U2C_UVEN_CV						,
			C.U3C_UVEN_CV						,
			C.U4C_UVEN_CV						,
			C.U5C_UVEN_CV						,
			C.U6C_UVEN_CV						,
			C.U9C_UVEN_CV						,
			C.U12C_UVEN_CV						,
			C.U15C_UVEN_CV						,
			C.U18C_UVEN_CV						,
			--C.U2C_DEV_CV						,
			--C.U3C_DEV_CV						,
			--C.U4C_DEV_CV						,
			--C.U5C_DEV_CV						,
			--C.U6C_DEV_CV						,
			--C.U9C_DEV_CV						,
			--C.U12C_DEV_CV						,
			--C.U15C_DEV_CV						,
			--C.U18C_DEV_CV						,
			C.U2C_ANU_CV						,
			C.U3C_ANU_CV						,
			C.U4C_ANU_CV						,
			C.U5C_ANU_CV						,
			C.U6C_ANU_CV						,
			C.U9C_ANU_CV						,
			C.U12C_ANU_CV						,
			C.U15C_ANU_CV						,
			C.U18C_ANU_CV						,
			C.U2C_VTA_CV						,
			C.U3C_VTA_CV						,
			C.U4C_VTA_CV						,
			C.U5C_VTA_CV						,
			C.U6C_VTA_CV						,
			C.U9C_VTA_CV						,
			C.U12C_VTA_CV						,
			C.U15C_VTA_CV						,
			C.U18C_VTA_CV						,
			C.U2C_AHORR_CV						,
			C.U3C_AHORR_CV						,
			C.U4C_AHORR_CV						,
			C.U5C_AHORR_CV						,
			C.U6C_AHORR_CV						,
			C.U9C_AHORR_CV						,
			C.U12C_AHORR_CV						,
			C.U15C_AHORR_CV						,
			C.U18C_AHORR_CV						,
			C.UC_RAT_FAL_CV						,
			C.U2C_RAT_FAL_CV					,
			C.U3C_RAT_FAL_CV					,
			C.U4C_RAT_FAL_CV					,
			C.U5C_RAT_FAL_CV					,
			C.U6C_RAT_FAL_CV					,
			C.U9C_RAT_FAL_CV					,
			C.U12C_RAT_FAL_CV					,
			C.U15C_RAT_FAL_CV					,
			C.U18C_RAT_FAL_CV					,
			--C.UC_RAT_DEV_CV					,
			--C.U2C_RAT_DEV_CV					,
			--C.U3C_RAT_DEV_CV					,
			--C.U4C_RAT_DEV_CV					,
			--C.U5C_RAT_DEV_CV					,
			--C.U6C_RAT_DEV_CV					,
			--C.U9C_RAT_DEV_CV					,
			--C.U12C_RAT_DEV_CV					,
			--C.U15C_RAT_DEV_CV					,
			--C.U18C_RAT_DEV_CV					,
			C.UC_RAT_ANU_CV						,
			C.U2C_RAT_ANU_CV					,
			C.U3C_RAT_ANU_CV					,
			C.U4C_RAT_ANU_CV					,
			C.U5C_RAT_ANU_CV					,
			C.U6C_RAT_ANU_CV					,
			C.U9C_RAT_ANU_CV					,
			C.U12C_RAT_ANU_CV					,
			C.U15C_RAT_ANU_CV					,
			C.U18C_RAT_ANU_CV					,
			C.UC_RAT_VTA_UNI_CV					,
			C.U2C_RAT_VTA_UNI_CV				,
			C.U3C_RAT_VTA_UNI_CV				,
			C.U4C_RAT_VTA_UNI_CV				,
			C.U5C_RAT_VTA_UNI_CV				,
			C.U6C_RAT_VTA_UNI_CV				,
			C.U9C_RAT_VTA_UNI_CV				,
			C.U12C_RAT_VTA_UNI_CV				,
			C.U15C_RAT_VTA_UNI_CV				,
			C.U18C_RAT_VTA_UNI_CV				,
			C.UC_RAT_AHOR_UNI_CV				,
			C.U2C_RAT_AHOR_UNI_CV				,
			C.U3C_RAT_AHOR_UNI_CV				,
			C.U4C_RAT_AHOR_UNI_CV				,
			C.U5C_RAT_AHOR_UNI_CV				,
			C.U6C_RAT_AHOR_UNI_CV				,
			C.U9C_RAT_AHOR_UNI_CV				,
			C.U12C_RAT_AHOR_UNI_CV				,
			C.U15C_RAT_AHOR_UNI_CV				,
			C.U18C_RAT_AHOR_UNI_CV				,
			D.UC_NumMarca						,
			D.U2C_NumMarca						,
			D.U3C_NumMarca						,
			D.U4C_NumMarca						,
			D.U5C_NumMarca						,
			D.U6C_NumMarca						,
			D.U9C_NumMarca						,
			D.U12C_NumMarca						,
			D.U15C_NumMarca						,
			D.U18C_NumMarca						,
			D.UC_NumCategorias					,
			D.U2C_NumCategorias					,
			D.U3C_NumCategorias					,
			D.U4C_NumCategorias					,
			D.U5C_NumCategorias					,
			D.U6C_NumCategorias					,
			D.U9C_NumCategorias					,
			D.U12C_NumCategorias				,
			D.U15C_NumCategorias				,
			D.U18C_NumCategorias				,
			D.UC_NumMarcaCategUC				,
			D.U2C_NumMarcaCategUC				,
			D.U3C_NumMarcaCategUC				,
			D.U4C_NumMarcaCategUC				,
			D.U5C_NumMarcaCategUC				,
			D.U6C_NumMarcaCategUC				,
			D.U9C_NumMarcaCategUC				,
			D.U12C_NumMarcaCategUC				,
			D.U15C_NumMarcaCategUC				,
			D.U18C_NumMarcaCategUC				,
			D.U2C_DESV_NumMarca					,
			D.U2C_DESV_NumCategorias			,
			D.U2C_DESV_NumMarcaCategUC			,
			D.U2C_MIN_NumMarca					,
			D.U2C_MIN_NumCategorias				,
			D.U2C_MIN_NumMarcaCategUC			,
			D.U2C_MAX_NumMarca					,
			D.U2C_MAX_NumCategorias				,
			D.U2C_MAX_NumMarcaCategUC			,
			D.U3C_DESV_NumMarca					,
			D.U3C_DESV_NumCategorias			,
			D.U3C_DESV_NumMarcaCategUC			,
			D.U3C_MIN_NumMarca					,
			D.U3C_MIN_NumCategorias				,
			D.U3C_MIN_NumMarcaCategUC			,
			D.U3C_MAX_NumMarca					,
			D.U3C_MAX_NumCategorias				,
			D.U3C_MAX_NumMarcaCategUC			,
			D.U4C_DESV_NumMarca					,
			D.U4C_DESV_NumCategorias			,
			D.U4C_DESV_NumMarcaCategUC			,
			D.U4C_MIN_NumMarca					,
			D.U4C_MIN_NumCategorias				,
			D.U4C_MIN_NumMarcaCategUC			,
			D.U4C_MAX_NumMarca					,
			D.U4C_MAX_NumCategorias				,
			D.U4C_MAX_NumMarcaCategUC			,
			D.U5C_DESV_NumMarca					,
			D.U5C_DESV_NumCategorias			,
			D.U5C_DESV_NumMarcaCategUC			,
			D.U5C_MIN_NumMarca					,
			D.U5C_MIN_NumCategorias				,
			D.U5C_MIN_NumMarcaCategUC			,
			D.U5C_MAX_NumMarca					,
			D.U5C_MAX_NumCategorias				,
			D.U5C_MAX_NumMarcaCategUC			,
			D.U6C_DESV_NumMarca					,
			D.U6C_DESV_NumCategorias			,
			D.U6C_DESV_NumMarcaCategUC			,
			D.U6C_MIN_NumMarca					,
			D.U6C_MIN_NumCategorias				,
			D.U6C_MIN_NumMarcaCategUC			,
			D.U6C_MAX_NumMarca					,
			D.U6C_MAX_NumCategorias				,
			D.U6C_MAX_NumMarcaCategUC			,
			D.U9C_DESV_NumMarca					,
			D.U9C_DESV_NumCategorias			,
			D.U9C_DESV_NumMarcaCategUC			,
			D.U9C_MIN_NumMarca					,
			D.U9C_MIN_NumCategorias				,
			D.U9C_MIN_NumMarcaCategUC			,
			D.U9C_MAX_NumMarca					,
			D.U9C_MAX_NumCategorias				,
			D.U9C_MAX_NumMarcaCategUC			,
			D.U12C_DESV_NumMarca				,
			D.U12C_DESV_NumCategorias			,
			D.U12C_DESV_NumMarcaCategUC			,
			D.U12C_MIN_NumMarca					,
			D.U12C_MIN_NumCategorias			,
			D.U12C_MIN_NumMarcaCategUC			,
			D.U12C_MAX_NumMarca					,
			D.U12C_MAX_NumCategorias			,
			D.U12C_MAX_NumMarcaCategUC			,
			D.U15C_DESV_NumMarca				,
			D.U15C_DESV_NumCategorias			,
			D.U15C_DESV_NumMarcaCategUC			,
			D.U15C_MIN_NumMarca					,
			D.U15C_MIN_NumCategorias			,
			D.U15C_MIN_NumMarcaCategUC			,
			D.U15C_MAX_NumMarca					,
			D.U15C_MAX_NumCategorias			,
			D.U15C_MAX_NumMarcaCategUC			,
			D.U18C_DESV_NumMarca				,
			D.U18C_DESV_NumCategorias			,
			D.U18C_DESV_NumMarcaCategUC			,
			D.U18C_MIN_NumMarca					,
			D.U18C_MIN_NumCategorias			,
			D.U18C_MIN_NumMarcaCategUC			,
			D.U18C_MAX_NumMarca					,
			D.U18C_MAX_NumCategorias			,
			D.U18C_MAX_NumMarcaCategUC			,
			D.U2C_PRO_NumMarca					,
			D.U2C_PRO_NumCategorias				,
			D.U2C_PRO_NumMarcaCategUC			,
			D.U3C_PRO_NumMarca					,
			D.U3C_PRO_NumCategorias				,
			D.U3C_PRO_NumMarcaCategUC			,
			D.U4C_PRO_NumMarca					,
			D.U4C_PRO_NumCategorias				,
			D.U4C_PRO_NumMarcaCategUC			,
			D.U5C_PRO_NumMarca					,
			D.U5C_PRO_NumCategorias				,
			D.U5C_PRO_NumMarcaCategUC			,
			D.U6C_PRO_NumMarca					,
			D.U6C_PRO_NumCategorias				,
			D.U6C_PRO_NumMarcaCategUC			,
			D.U9C_PRO_NumMarca					,
			D.U9C_PRO_NumCategorias				,
			D.U9C_PRO_NumMarcaCategUC			,
			D.U12C_PRO_NumMarca					,
			D.U12C_PRO_NumCategorias			,
			D.U12C_PRO_NumMarcaCategUC			,
			D.U15C_PRO_NumMarca					,
			D.U15C_PRO_NumCategorias			,
			D.U15C_PRO_NumMarcaCategUC			,
			D.U18C_PRO_NumMarca					,
			D.U18C_PRO_NumCategorias			,
			D.U18C_PRO_NumMarcaCategUC			,
			D.TEND_NumCategorias_U2C			,
			D.TEND_NumCategorias_U3C			,
			D.TEND_NumCategorias_U4C			,
			D.TEND_NumCategorias_U5C			,
			D.TEND_NumCategorias_U6C			,
			D.TEND_NumCategorias_U9C			,
			D.TEND_NumCategorias_U12C			,
			D.TEND_NumCategorias_U15C			,
			D.TEND_NumCategorias_U18C			,
			D.TEND_NumMarca_U2C					,
			D.TEND_NumMarca_U3C					,
			D.TEND_NumMarca_U4C					,
			D.TEND_NumMarca_U5C					,
			D.TEND_NumMarca_U6C					,
			D.TEND_NumMarca_U9C					,
			D.TEND_NumMarca_U12C				,
			D.TEND_NumMarca_U15C				,
			D.TEND_NumMarca_U18C				,
			D.TEND_NumMarcaCategUC_U2C			,
			D.TEND_NumMarcaCategUC_U3C			,
			D.TEND_NumMarcaCategUC_U4C			,
			D.TEND_NumMarcaCategUC_U5C			,
			D.TEND_NumMarcaCategUC_U6C			,
			D.TEND_NumMarcaCategUC_U9C			,
			D.TEND_NumMarcaCategUC_U12C			,
			D.TEND_NumMarcaCategUC_U15C			,
			D.TEND_NumMarcaCategUC_U18C			,
			D.TEND_TRI_NumCategorias_U3C		,
			D.TEND_TRI_NumCategorias_U6C		,
			D.TEND_TRI_NumCategorias_U9C		,
			D.TEND_TRI_NumCategorias_U12C		,
			D.TEND_TRI_NumCategorias_U15C		,
			D.TEND_TRI_NumMarca_U3C				,
			D.TEND_TRI_NumMarca_U6C				,
			D.TEND_TRI_NumMarca_U9C				,
			D.TEND_TRI_NumMarca_U12C			,
			D.TEND_TRI_NumMarca_U15C			,
			D.TEND_TRI_NumMarcaCategUC_U3C		,
			D.TEND_TRI_NumMarcaCategUC_U6C		,
			D.TEND_TRI_NumMarcaCategUC_U9C		,
			D.TEND_TRI_NumMarcaCategUC_U12C		,
			D.TEND_TRI_NumMarcaCategUC_U15C		,
			D.U2C_NumCategorias_CV				,
			D.U2C_NumMarca_CV					,
			D.U2C_NumMarcaCategUC_CV			,
			D.U3C_NumCategorias_CV				,
			D.U3C_NumMarca_CV					,
			D.U3C_NumMarcaCategUC_CV			,
			D.U4C_NumCategorias_CV				,
			D.U4C_NumMarca_CV					,
			D.U4C_NumMarcaCategUC_CV			,
			D.U5C_NumCategorias_CV				,
			D.U5C_NumMarca_CV					,
			D.U5C_NumMarcaCategUC_CV			,
			D.U6C_NumCategorias_CV				,
			D.U6C_NumMarca_CV					,
			D.U6C_NumMarcaCategUC_CV			,
			D.U9C_NumCategorias_CV				,
			D.U9C_NumMarca_CV					,
			D.U9C_NumMarcaCategUC_CV			,
			D.U12C_NumCategorias_CV				,
			D.U12C_NumMarca_CV					,
			D.U12C_NumMarcaCategUC_CV			,
			D.U15C_NumCategorias_CV				,
			D.U15C_NumMarca_CV					,
			D.U15C_NumMarcaCategUC_CV			,
			D.U18C_NumCategorias_CV				,
			D.U18C_NumMarca_CV					,
			D.U18C_NumMarcaCategUC_CV			    
	FROM BD_ANALITICO.dbo.MDL_NPP_Target A 
	LEFT JOIN BD_ANALITICO.dbo.MDL_NPP_MCC B ON A.AnioCampanaUC = B.AnioCampana AND A.PKebelista = B.PkEbelista
	LEFT JOIN BD_ANALITICO.dbo.MDL_NPP_Venta C ON A.AnioCampanaUC = C.AnioCampana AND A.Pkebelista = C.PkEbelista 
	LEFT JOIN BD_ANALITICO.dbo.MDL_NPP_Marca_Categoria D ON A.AnioCampanaUC = D.AnioCampana AND A.PkEbelista = D.PkEbelista

	
	IF OBJECT_ID('BD_ANALITICO.dbo.MDL_NPP_Target') IS NOT NULL DROP TABLE BD_ANALITICO.dbo.MDL_NPP_Target
	IF OBJECT_ID('BD_ANALITICO.dbo.MDL_NPP_MCC') IS NOT NULL DROP TABLE BD_ANALITICO.dbo.MDL_NPP_MCC
	IF OBJECT_ID('BD_ANALITICO.dbo.MDL_NPP_Venta') IS NOT NULL DROP TABLE BD_ANALITICO.dbo.MDL_NPP_Venta
	IF OBJECT_ID('BD_ANALITICO.dbo.MDL_NPP_Marca_Categoria') IS NOT NULL DROP TABLE BD_ANALITICO.dbo.MDL_NPP_Marca_Categoria
	

END





