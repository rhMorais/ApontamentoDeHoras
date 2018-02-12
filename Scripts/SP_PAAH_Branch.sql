IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_PostBranch]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_PostBranch]
GO

CREATE PROCEDURE [dbo].[PAAHSP_PostBranch]
	@Branch_Nome			VARCHAR(20),
	@Branch_DataCriacao		DATETIME = NULL

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Branch.sql
	Objetivo..........: Inserir branchs
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_PostBranch] 'FIX001-2017'
	*/

	BEGIN
	
		INSERT INTO [dbo].[PAAH_Branch] (Branch_Nome, Branch_DataCriacao)
			VALUES (@Branch_Nome, ISNULL(@Branch_DataCriacao, GETDATE()))

		IF @@ERROR <> 0
			RETURN -1
		RETURN SCOPE_IDENTITY()
					
	END
GO
--_______________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_UpdateBranch]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_UpdateBranch]
GO

CREATE PROCEDURE [dbo].[PAAHSP_UpdateBranch]
	@Branch_Sequencial		INT,
	@Branch_Nome			VARCHAR(20)

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Branch.sql
	Objetivo..........: Editar branchs
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_DeleteBranch] 1, 'FIX001-2017'
	*/

	BEGIN
	
		UPDATE [dbo].[PAAH_Branch] 
			SET Branch_Nome = @Branch_Nome
			WHERE Branch_Sequencial = @Branch_Sequencial
		
	END
GO
--_______________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_DeleteBranch]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_DeleteBranch]
GO

CREATE PROCEDURE [dbo].[PAAHSP_DeleteBranch]
	@Branch_Sequencial		INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Branch.sql
	Objetivo..........: Deletar branchs
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_DeleteBranch] 1
	*/

	BEGIN
	
		DELETE [dbo].[PAAH_Branch] 
			WHERE Branch_Sequencial = @Branch_Sequencial
		
	END
GO
--________________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_SelectListBranch]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_SelectListBranch]
GO

CREATE PROCEDURE [dbo].[PAAHSP_SelectListBranch]
	@Branch_Nome		VARCHAR(20) = NULL

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Branch.sql
	Objetivo..........: Selecionar todos os branchs
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_SelectListBranch]
	*/

	BEGIN
	
		SELECT	Branch_Sequencial,
				Branch_Nome,
				Branch_DataCriacao
			FROM [dbo].[PAAH_Branch] WITH(NOLOCK)
			WHERE @Branch_Nome IS NULL OR Branch_Nome LIKE '%' + @Branch_Nome + '%'
	END
GO
--________________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_SelectBranch]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_SelectBranch]
GO

CREATE PROCEDURE [dbo].[PAAHSP_SelectBranch]
	@Branch_Sequencial		INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Branch.sql
	Objetivo..........: Selecionar um branch
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_SelectBranch]
	*/

	BEGIN
	
		SELECT	Branch_Sequencial,
				Branch_Nome,
				Branch_DataCriacao
			FROM [dbo].[PAAH_Branch] WITH(NOLOCK)
			WHERE Branch_Sequencial = @Branch_Sequencial
	END
GO