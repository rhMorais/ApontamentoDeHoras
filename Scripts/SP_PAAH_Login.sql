IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_PostEnvolvido]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_PostEnvolvido]
GO

CREATE PROCEDURE [dbo].[PAAHSP_PostEnvolvido]
	@Envol_Nome				VARCHAR(100),
	@Envol_Email			VARCHAR(200),
	@TipoEnvol_Sequencial	INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Envolvido.sql
	Objetivo..........: Inserir Envolvidos
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_PostEnvolvido] 'FIX001-2017'
	*/

	BEGIN
	
		INSERT INTO [dbo].[PAAH_Envolvido] (Envol_Nome, Envol_Email, TipoEnvol_Sequencial)
			VALUES (@Envol_Nome, @Envol_Email, @TipoEnvol_Sequencial)

		IF @@ERROR <> 0
			RETURN -1
		RETURN SCOPE_IDENTITY()
					
	END
GO
--_______________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_UpdateEnvolvido]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_UpdateEnvolvido]
GO

CREATE PROCEDURE [dbo].[PAAHSP_UpdateEnvolvido]
	@Envol_Sequencial		INT,
	@Envol_Nome				VARCHAR(100),
	@Envol_Email			VARCHAR(200),
	@TipoEnvol_Sequencial	INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Envolvido.sql
	Objetivo..........: Editar Envolvidos
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_UpdateEnvolvido] 1, 'FIX001-2017'
	*/

	BEGIN
	
		UPDATE [dbo].[PAAH_Envolvido] 
			SET Envol_Nome				= @Envol_Nome,
				Envol_Email				= @Envol_Email,
				TipoEnvol_Sequencial	= @TipoEnvol_Sequencial
			WHERE Envol_Sequencial = @Envol_Sequencial
		
	END
GO
--_______________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_DeleteEnvolvido]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_DeleteEnvolvido]
GO

CREATE PROCEDURE [dbo].[PAAHSP_DeleteEnvolvido]
	@Envol_Sequencial		INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Envolvido.sql
	Objetivo..........: Deletar Envolvidos
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_DeleteEnvolvido] 1
	*/

	BEGIN
	
		DELETE [dbo].[PAAH_Envolvido] 
			WHERE Envol_Sequencial = @Envol_Sequencial
		
	END
GO
--________________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_SelectListEnvolvido]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_SelectListEnvolvido]
GO

CREATE PROCEDURE [dbo].[PAAHSP_SelectListEnvolvido]
	@Envol_Nome				VARCHAR(20) = NULL,
	@TipoEnvol_Sequencial	INT = NULL

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Envolvido.sql
	Objetivo..........: Selecionar todos os Envolvidos
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_SelectListEnvolvido]
	*/

	BEGIN
	
		SELECT	env.Envol_Sequencial,
				env.Envol_Nome,
				env.Envol_Email,
				tip.TipoEnvol_Sequencial,
				tip.TipoEnvol_Descricao
			FROM [dbo].[PAAH_Envolvido] env WITH(NOLOCK)
				INNER JOIN [dbo].[PAAH_TipoEnvolvido] tip 
					ON tip.TipoEnvol_Sequencial = env.TipoEnvol_Sequencial
			WHERE	(@Envol_Nome IS NULL OR	env.Envol_Nome LIKE '%' + @Envol_Nome + '%')
				AND	(@TipoEnvol_Sequencial IS NULL OR tip.TipoEnvol_Sequencial = @TipoEnvol_Sequencial) 
	END
GO
--________________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_SelectEnvolvido]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_SelectEnvolvido]
GO

CREATE PROCEDURE [dbo].[PAAHSP_SelectEnvolvido]
	@Envol_Sequencial		INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Envolvido.sql
	Objetivo..........: Selecionar um Envolvido
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_SelectEnvolvido]
	*/

	BEGIN
	
		SELECT	Envol_Sequencial,
				Envol_Nome,
				Envol_Email,
				TipoEnvol_Sequencial
			FROM [dbo].[PAAH_Envolvido] WITH(NOLOCK)
			WHERE Envol_Sequencial = @Envol_Sequencial
	END
GO