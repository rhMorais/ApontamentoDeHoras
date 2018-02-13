IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_PostProjeto]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_PostProjeto]
GO

CREATE PROCEDURE [dbo].[PAAHSP_PostProjeto]
	@Proj_Nome				VARCHAR(200)

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Projeto.sql
	Objetivo..........: Inserir Projetos
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_PostProjeto] 'FIX001-2017'
	*/

	BEGIN
	
		INSERT INTO [dbo].[PAAH_Projeto] (Proj_Nome)
			VALUES (@Proj_Nome)

		IF @@ERROR <> 0
			RETURN -1
		RETURN SCOPE_IDENTITY()
					
	END
GO
--_______________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_UpdateProjeto]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_UpdateProjeto]
GO

CREATE PROCEDURE [dbo].[PAAHSP_UpdateProjeto]
	@Proj_Sequencial		INT,
	@Proj_Nome				VARCHAR(20)

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Projeto.sql
	Objetivo..........: Editar Projetos
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_DeleteProjeto] 1, 'FIX001-2017'
	*/

	BEGIN
	
		UPDATE [dbo].[PAAH_Projeto] 
			SET Proj_Nome = @Proj_Nome
			WHERE Proj_Sequencial = @Proj_Sequencial
		
	END
GO
--_______________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_DeleteProjeto]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_DeleteProjeto]
GO

CREATE PROCEDURE [dbo].[PAAHSP_DeleteProjeto]
	@Proj_Sequencial		INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Projeto.sql
	Objetivo..........: Deletar Projetos
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_DeleteProjeto] 1
	*/

	BEGIN
	
		DELETE [dbo].[PAAH_Projeto] 
			WHERE Proj_Sequencial = @Proj_Sequencial
		
	END
GO
--________________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_SelectListProjeto]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_SelectListProjeto]
GO

CREATE PROCEDURE [dbo].[PAAHSP_SelectListProjeto]
	@Proj_Nome		VARCHAR(20) = NULL

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Projeto.sql
	Objetivo..........: Selecionar todos os Projetos
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_SelectListProjeto]
	*/

	BEGIN
	
		SELECT	Proj_Sequencial,
				Proj_Nome
			FROM [dbo].[PAAH_Projeto] WITH(NOLOCK)
			WHERE @Proj_Nome IS NULL OR Proj_Nome LIKE '%' + @Proj_Nome + '%'
	END
GO
--________________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_SelectProjeto]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_SelectProjeto]
GO

CREATE PROCEDURE [dbo].[PAAHSP_SelectProjeto]
	@Proj_Sequencial		INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Projeto.sql
	Objetivo..........: Selecionar um Projeto
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_SelectProjeto]
	*/

	BEGIN
	
		SELECT	Proj_Sequencial,
				Proj_Nome
			FROM [dbo].[PAAH_Projeto] WITH(NOLOCK)
			WHERE Proj_Sequencial = @Proj_Sequencial
	END
GO