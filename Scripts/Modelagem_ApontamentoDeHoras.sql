-- PROJETO AUXILIAR DE APONTAMENTO DE HORAS

CREATE TABLE PAAH_Branch (
	Branch_Sequencial 		INT,
	Branch_Nome		VARCHAR(20),
	Branch_Sequencial 		CONSTRAINT PK_Branch PRIMARY KEY IDENTITY(1,1)
)

CREATE TABLE PAAH_TipoProjeto (
	TipoProj_Sequencial 	INT,
	TipoProj_Descricao 		VARHCAR(100),
	TipoProj_Sequencial 	CONSTRAINT PK_TipoProjeto PRIMARY KEY IDENTITY(1,1)
)

CREATE TABLE PAAH_StatusApontamento(
	Status_Sequencial 		INT,
	Status_Descricao		VARCHAR(50),
	Status_Sequencial 		CONSTRAINT PK_StatusApontamento  PRIMARY KEY IDENTITY(1,1)
)

CREATE TABLE PAAH_TipoEnvolvido(
	TipoEnvol_Sequencial 	INT,
	TipoEnvol_Descricao		VARCHAR(100),
	TipoEnvol_Sequencial 	CONSTRAINT PK_TipoEnvolvido PRIMARY KEY IDENTITY(1,1)
)

CREATE TABLE PAAH_Projeto(
	Proj_Sequencial 		INT,
	Proj_Nome		VARCHAR(200),
	TipoProj_Sequencial		INT,
	Proj_Sequencial 		CONSTRAINT PK_Projeto PRIMARY KEY IDENTITY(1,1),
	TipoProj_Sequencial 	CONSTRAINT FK_Projeto_TipoProjeto FOREIGN KEY  REFERENCES PAAH_TipoProjeto (TipoProj_Sequencial)
)

CREATE TABLE PAAH_Envolvido(
	Envol_Sequencial 		INT,
	Envol_Nome		VARCHAR(150),
	Envol_Email		VARCHAR(150),
	TipoEnvol_Sequencial	INT,
	Envol_Sequencial 		CONSTRAINT PK_Envolvido PRIMARY KEY IDENTITY(1,1),
	TipoEnvol_Sequencial	CONSTRAINT FK_Envolvido_TipoEnvolvido FOREIGN KEY REFERENCES PAAH_TipoEnvolvido(TipoEnvol_Sequencial)
)

CREATE TABLE PAAH_Login(
	Login_Sequencial		INT,
	Login_Senha		VARCHAR(10),
	Login_DataSenha		DATETIME,
	Envol_Sequencial		INT,	
	Login_Sequencial		CONSTRAINT PK_Login PRIMARY KEY IDENTITY(1,1),
	Envol_Sequencial		CONSTRAINT FK_Login_Envolvido FOREIGN KEY REFERENCES PAAH_Envolvido(Envol_Sequencial)
)

CREATE TABLE PAAH_Apontamento(
	Apont_Sequencial		INT,
	Apont_TempoGasto		DATETIME,
	Apont_DataSolicitacao	DATETIME,
	Apont_DataInicio		DATETIME,
	Apont_DataTermino		DATETIME,
	Apont_Assunto		VARCHAR(200),
	Apont_Descricao		VARCHAR(255),
	Branch_Sequencial		INT,
	Apont_Sequencial		CONSTRAINT PK_Apontamento PRIMARY KEY IDENTITY (1,1),
	Branch_Sequencial		CONSTRAINT FK_Apontamento_Branch FOREIGN KEY REFERENCES PAAH_Branch(Branch_Sequencial)
)

CREATE TABLE PAAH_ApontamentoProjeto(
	Proj_Sequencial		INT CONSTRAINT FK_ApontamentoProjeto_Apontamento FOREIGN KEY REFERENCES PAAH_Apontamento(Apont_
Sequencial),
	Apont_Sequencial		INT CONSTRAINT FK_ApontamentoProjeto_Projeto FOREIGN KEY REFERENCES PAAH_Projeto(Proj_Sequencial),
	CONSTRAINT PK_ApontamentoProjeto (Proj_Sequencial, Apont_Sequencial)
)

CREATE TABLE PAAH_ApontamentoStatus(
	Status_Sequencial 		INT CONSTRAINT FK_ApontamentoStatus_Status FOREIGN KEY REFERENCES PAAH_Status(Status_Sequencial),
	Apont_Sequencial		INT CONSTRAINT FK_ApontamentoStatus_Apontamento FOREGN KEY REFERENVES PAAH_Apontamento(Apont_Sequencial)
	CONSTRAINT PK_ApontamentoStatus(Status_Sequencial, Apont_Sequencial)
)

CREATE TABLE PAAH_ApontamentoEnvolvido(
	Envol_Sequencial 		INT CONSTRAINT FK_ApontamentoEnvolvido_Envolvido FOREIGN KEY REFERENCES PAAH_Envolvido(Envol_Sequencial),
	Apont_Sequencial		INT CONSTRAINT FK_ApontamentoEnvolvido_Apontamento FOREIGN KEY REFERENCES PAAH_Apontamento(Apont_Sequencial)
	CONSTRAINT PK_ApontamentoEnvolvido(Envol_Sequencial, Apont_Sequencial)
)
	