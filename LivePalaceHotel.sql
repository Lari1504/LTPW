Drop database Hotelaria;
Create schema if not exists Hotelaria default character set utf8;
use Hotelaria;

CREATE TABLE login(
id_usuario INT NOT NULL AUTO_INCREMENT,
email VARCHAR(50) NOT NULL,
senha VARCHAR(50)NOT NULL,
data_criacao DATETIME NOT NULL,
data_alteracao DATETIME NOT NULL,
data_exclusao DATETIME NOT NULL,
versao LONGTEXT NOT NULL,
PRIMARY KEY(id_usuario)
);
select*from login;

CREATE TABLE Hotel (
    HotelID INT NOT NULL AUTO_INCREMENT,
    id_usuario INT,
    Nome VARCHAR(100),
    Endereco VARCHAR(255),
    PRIMARY KEY(HotelID),
	FOREIGN KEY (id_usuario) REFERENCES login(id_usuario)
);
select*from Hotel;

CREATE TABLE Quarto (
    QuartoID INT NOT NULL AUTO_INCREMENT,
    HotelID INT,
    TipoQuarto VARCHAR(50),
    Preco DECIMAL(10, 2),
    Disponivel BOOLEAN,
    PRIMARY KEY(QuartoID),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);
select*from Quarto;

CREATE TABLE Cliente (
    ClienteID INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100),
    Email VARCHAR(100),
    PRIMARY KEY(ClienteID)
);
select*from Cliente;

CREATE TABLE Funcionario (
    FuncionarioID INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100),
    Cargo VARCHAR(100),
    id_usuario INT,
    PRIMARY KEY(FuncionarioID),
    FOREIGN KEY (id_usuario) REFERENCES login(id_usuario)
);
select*from Funcionario;

CREATE TABLE Reserva (
    ReservaID INT NOT NULL AUTO_INCREMENT,
    ClienteID INT,
    QuartoID INT,
    DataEntrada DATE,
    DataSaida DATE,
    PRIMARY KEY(ReservaID),
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (QuartoID) REFERENCES Quarto(QuartoID)
);
select*from Reserva;

CREATE TABLE CheckIn (
    CheckInID INT NOT NULL AUTO_INCREMENT,
    ReservaID INT,
    DataHoraEntrada DATETIME,
    PRIMARY KEY(CheckInID),
    FOREIGN KEY (ReservaID) REFERENCES Reserva(ReservaID)
);
select*from CheckIn;

CREATE TABLE CheckOut (
    CheckOutID INT NOT NULL AUTO_INCREMENT,
    CheckInID INT,
    DataHoraSaida DATETIME,
    ValorTotal DECIMAL(10, 2),
    PRIMARY KEY(CheckOutID),
    FOREIGN KEY (CheckInID) REFERENCES CheckIn(CheckInID)
);
select*from CheckOut;

CREATE TABLE CarrinhoCompras (
    CarrinhoID INT NOT NULL AUTO_INCREMENT,
    ClienteID INT,
    QuartoID INT,
    Quantidade INT,
    PRIMARY KEY(CarrinhoID),
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (QuartoID) REFERENCES Quarto(QuartoID)
);
select*from CarrinhoCompras;

INSERT INTO login (email, senha, data_criacao, data_alteracao, data_exclusao, versao) 
VALUES ('usuario1@email.com', 'senha123', NOW(), NOW(), NOW(), '1.0'),
       ('usuario2@email.com', 'senha456', NOW(), NOW(), NOW(), '1.0');

INSERT INTO Hotel (id_usuario, Nome, Endereco) 
VALUES (1, 'Hotel A', 'Endereço do Hotel A'),
       (2, 'Hotel B', 'Endereço do Hotel B');

INSERT INTO Quarto (HotelID, TipoQuarto, Preco, Disponivel) 
VALUES (1, 'Single', 100.00, TRUE),
       (1, 'Duplo', 150.00, TRUE),
       (2, 'Single', 120.00, TRUE),
       (2, 'Duplo', 180.00, TRUE);

INSERT INTO Cliente (Nome, Email) 
VALUES ('Cliente 1', 'cliente1@email.com'),
       ('Cliente 2', 'cliente2@email.com');

INSERT INTO Funcionario (Nome, Cargo, id_usuario) 
VALUES ('Funcionário 1', 'Recepcionista', 1),
       ('Funcionário 2', 'Gerente', 2);

INSERT INTO Reserva (ClienteID, QuartoID, DataEntrada, DataSaida) 
VALUES (1, 1, '2024-05-10', '2024-05-15'),
       (2, 3, '2024-05-12', '2024-05-18');

INSERT INTO CheckIn (ReservaID, DataHoraEntrada) 
VALUES (1, NOW()),
       (2, NOW());

INSERT INTO CheckOut (CheckInID, DataHoraSaida, ValorTotal) 
VALUES (1, NOW(), 500.00),
       (2, NOW(), 720.00);

INSERT INTO CarrinhoCompras (ClienteID, QuartoID, Quantidade) 
VALUES (1, 2, 2),
       (2, 4, 1);