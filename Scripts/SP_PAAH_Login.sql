IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_PostLogin]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_PostLogin]
GO

CREATE PROCEDURE [dbo].[PAAHSP_PostLogin]
	@Login_Senha				VARCHAR(12),
	@Login_DataSenha			DATETIME = NULL,
	@Envol_Sequencial			INT
	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Login.sql
	Objetivo..........: Inserir Logins
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_PostLogin] 'FIX001-2017'
	*/

	BEGIN
	
		INSERT INTO [dbo].[PAAH_Login] (Login_Senha, Login_DataSenha, Envol_Sequencial)
			VALUES (@Login_Senha, (ISNULL(@Login_DataSenha, GETDATE())), @Envol_Sequencial)

		IF @@ERROR <> 0
			RETURN -1
		RETURN SCOPE_IDENTITY()
					
	END
GO
--_______________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_UpdateLogin]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_UpdateLogin]
GO

CREATE PROCEDURE [dbo].[PAAHSP_UpdateLogin]
	@Login_Sequencial			INT,
	@Login_Senha				VARCHAR(12),
	@Login_DataSenha			DATETIME = NULL,
	@Envol_Sequencial			INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Login.sql
	Objetivo..........: Editar Logins
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_UpdateLogin] 1, 'FIX001-2017'
	*/

	BEGIN
	
		UPDATE [dbo].[PAAH_Login] 
			SET Login_Senha					= @Login_Senha,
				Login_DataSenha				= @Login_DataSenha,
				Envol_Sequencial			= @Envol_Sequencial
			WHERE Login_Sequencial 			= @Login_Sequencial
		
	END
GO
--_______________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_DeleteLogin]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_DeleteLogin]
GO

CREATE PROCEDURE [dbo].[PAAHSP_DeleteLogin]
	@Login_Sequencial		INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Login.sql
	Objetivo..........: Deletar Logins
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_DeleteLogin] 1
	*/

	BEGIN
	
		DELETE [dbo].[PAAH_Login] 
			WHERE Login_Sequencial = @Login_Sequencial
		
	END
GO
--________________________________________________________________________________________________________________________________________________--

-- IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_SelectListLogin]') AND objectproperty(id, N'IsPROCEDURE')=1)
-- 	DROP PROCEDURE [dbo].[PAAHSP_SelectListLogin]
-- GO

-- CREATE PROCEDURE [dbo].[PAAHSP_SelectListLogin]
-- 	@Login_Nome				VARCHAR(20) = NULL,
-- 	@TipoEnvol_Sequencial	INT 		= NULL

-- 	AS
			
-- 	/*
-- 	Arquivo Fonte.....: SP_PAAH_Login.sql
-- 	Objetivo..........: Selecionar todos os Logins
-- 	Autor.............: Rafael Morais
--  	Data..............: 12/02/2018
-- 	Ex................: EXEC [dbo].[PAAHSP_SelectListLogin]
-- 	*/

-- 	BEGIN
	
-- 		SELECT	env.Envol_Sequencial,
-- 				env.Envol_Nome,
-- 				env.Envol_Email,
-- 				tip.TipoEnvol_Sequencial,
-- 				tip.TipoEnvol_Descricao
-- 			FROM [dbo].[PAAH_Login] env WITH(NOLOCK)
-- 				INNER JOIN [dbo].[PAAH_TipoLogin] tip 
-- 					ON tip.TipoEnvol_Sequencial = env.TipoEnvol_Sequencial
-- 			WHERE	(@Login_Nome IS NULL OR	env.Envol_Nome LIKE '%' + @Login_Nome + '%')
-- 				AND	(@TipoEnvol_Sequencial IS NULL OR tip.TipoEnvol_Sequencial = @TipoEnvol_Sequencial) 
-- 	END
-- GO
--________________________________________________________________________________________________________________________________________________--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PAAHSP_SelectLogin]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PAAHSP_SelectLogin]
GO

CREATE PROCEDURE [dbo].[PAAHSP_SelectLogin]
	@Login_Sequencial		INT

	AS
			
	/*
	Arquivo Fonte.....: SP_PAAH_Login.sql
	Objetivo..........: Selecionar um Login
	Autor.............: Rafael Morais
 	Data..............: 12/02/2018
	Ex................: EXEC [dbo].[PAAHSP_SelectLogin]
	*/

	BEGIN
	
		SELECT	l.Login_Sequencial,
				l.Login_DataSenha,
				l.Login_Senha,
				e.Envol_Sequencial,
				e.Envol_Nome,
				t.TipoEnvol_Sequencial,
				t.TipoEnvol_Descricao
			FROM [dbo].[PAAH_Login] l WITH(NOLOCK)
				INNER JOIN [dbo].[PAAH_Envolvido] e WITH (NOLOCK)
					ON e.Envol_Sequencial = l.Envol_Sequencial
				INNER JOIN [dbo].[PAAH_TipoEnvolvido] t WITH(NOLOCK)
					ON t.TipoEnvol_Sequencial = e.TipoEnvol_Sequencial
			WHERE Envol_Sequencial = @Login_Sequencial
	END
GO