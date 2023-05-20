-- Comando para criar o usuário
CREATE USER gabriel WITH ENCRYPTED PASSWORD '123' CREATEDB CREATEROLE;

-- Comando para criar o banco de dados com as especificações corretas e com o usuário criado sendo dono
CREATE DATABASE uvv OWNER gabriel TEMPLATE template0 ENCODING 'UTF8' LC_COLLATE 'pt_BR.UTF-8' LC_CTYPE 'pt_BR.UTF-8' ALLOW_CONNECTIONS true;

--Comando para conectar no banco de dados criado
\c uvv gabriel

-- Comando para criar o esquema
CREATE SCHEMA lojas AUTHORIZATION gabriel;

-- Comando para alterar o esquema padrão
SET search_path TO lojas, "$user", public;

-- Deixar o ultimo comando permanente
ALTER USER gabriel

SET search_path TO lojas, "$user", public;

CREATE TABLE lojas.clientes (

                cliente_id   NUMERIC(38) NOT NULL,

                email        VARCHAR(255) NOT NULL,

                nome         VARCHAR(255) NOT NULL,

                telefone1    VARCHAR(20),

                telefone2    VARCHAR(20),

                telefone3    VARCHAR(20),

                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)

);

COMMENT ON TABLE lojas.clientes IS 'Tabela que guarda informações dos clientes';

COMMENT ON COLUMN lojas.clientes.cliente_id IS 'PK da tabela clientes , atribui um ID para cada cliente';

COMMENT ON COLUMN lojas.clientes.email IS 'Email de cada cliente';

COMMENT ON COLUMN lojas.clientes.nome IS 'Nome de cada cliente';

COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Telefone do cliente';

COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Mais uma opção de telefone para o cliente';

COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Mais uma opção de telefone para o cliente';

CREATE TABLE lojas.produtos (

                produto_id                 NUMERIC(38) NOT NULL,

                nome                       VARCHAR(255) NOT NULL,

                preco_unitario             NUMERIC(10,2),

                detalhes                   BYTEA,

                imagem                     BYTEA,

                imagem_mime_type           VARCHAR(512),

                imagem_arquivo             VARCHAR(512),

                imagem_charset             VARCHAR(512),

                imagem_ultima_atualizacao  DATE,

                CONSTRAINT produto_id PRIMARY KEY (produto_id)

);

COMMENT ON TABLE lojas.produtos IS 'Tabela que armazena dados sobre os produtos';

COMMENT ON COLUMN lojas.produtos.produto_id IS 'PK da tabela produtos , atribui um ID para cada produto';

COMMENT ON COLUMN lojas.produtos.nome IS 'Nome de cada produto';

COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço da unidade de um produto';

COMMENT ON COLUMN lojas.produtos.detalhes IS 'Detalhes do produto';

COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem para apresentar o produto';

COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Tipo de arquivo de midia da imagem';

COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Arquivo da imagem';

COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Codificação de caracteres da imagem';

COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Última atualização da imagem';

CREATE TABLE lojas.lojas (

                loja_id                   NUMERIC(38) NOT NULL,

                nome                      VARCHAR(255) NOT NULL,

                endereco_web              VARCHAR(100),

                endereco_fisico           VARCHAR(512),

                latitude                  NUMERIC,

                longitude                 NUMERIC,

                logo                      BYTEA,

                logo_mime_type            VARCHAR(512),

                logo_arquivo              VARCHAR(512),

                logo_charset              VARCHAR(512),

                logo_ultima_atualizacao   DATE,

                CONSTRAINT loja_id PRIMARY KEY (loja_id)

);

COMMENT ON TABLE lojas.lojas IS 'Tabela que armazena as lojas e seus dados';

COMMENT ON COLUMN lojas.lojas.loja_id IS 'PK da tabela lojas , que atribui um ID para cada loja';

COMMENT ON COLUMN lojas.lojas.nome IS 'Nome da loja';

COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Endereço web da loja (URL)';

COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Localização da loja fisica';

COMMENT ON COLUMN lojas.lojas.latitude IS 'Localização latidudinal da loja';

COMMENT ON COLUMN lojas.lojas.longitude IS 'Localização longitudinal da loja';

COMMENT ON COLUMN lojas.lojas.logo IS 'Logomarca da loja';

COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Tipo de midia da internet do logo';

COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Arquivo do logo da loja';

COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Codificação de caracteres do logo';

COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data da última atualização do logo';

CREATE TABLE lojas.envios (

                envio_id         NUMERIC(38) NOT NULL,

                loja_id          NUMERIC(38) NOT NULL,

                cliente_id       NUMERIC(38) NOT NULL,

                endereco_entrega VARCHAR(512) NOT NULL,

                status           VARCHAR(15) NOT NULL,

                CONSTRAINT envio_id PRIMARY KEY (envio_id)

);

COMMENT ON TABLE lojas.envios IS 'Tabela que armazena informações sobre o envio dos pedidos';

COMMENT ON COLUMN lojas.envios.envio_id IS 'PK da tabela envios , atribui um ID para cada envio';

COMMENT ON COLUMN lojas.envios.loja_id IS 'FK para a tabela lojas, atribui um ID para cada loja';

COMMENT ON COLUMN lojas.envios.cliente_id IS 'FK para a tabela clientes , atribui um ID para cada cliente';

COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço para entrega do pedido';

COMMENT ON COLUMN lojas.envios.status IS 'Situação atual do envio';

CREATE TABLE lojas.estoques (

                estoque_id    NUMERIC(38) NOT NULL,

                loja_id       NUMERIC(38) NOT NULL,

                produto_id    NUMERIC(38) NOT NULL,

                quantidade    NUMERIC(38),

                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)

);

COMMENT ON TABLE lojas.estoques IS 'Tabela que guarda dados sobre os estoques';

COMMENT ON COLUMN lojas.estoques.estoque_id IS 'PK da tabela estoques , atribui um ID para cada estoque';

COMMENT ON COLUMN lojas.estoques.loja_id IS 'FK para a tabela lojas, atribui um ID para cada loja';

COMMENT ON COLUMN lojas.estoques.produto_id IS 'FK para a tabela produtos , atribui um ID para cada produto';

COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade de um produto no estoque';

CREATE TABLE lojas.pedidos (

                pedido_id     NUMERIC(38) NOT NULL,

                data_hora     TIMESTAMP NOT NULL,

                cliente_id    NUMERIC(38) NOT NULL,

                status        VARCHAR(15) NOT NULL,

                loja_id       NUMERIC(38) NOT NULL,

                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)

);

COMMENT ON TABLE lojas.pedidos IS 'Tabela que guarda informações sobre os pedidos';

COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'PK da tabela pedidos , atribuiu um ID para cada pedido';

COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Data e hora do pedido';

COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'FK para a tabela clientes , atribui um ID para cada cliente';

COMMENT ON COLUMN lojas.pedidos.status IS 'Situação atual do pedido';

COMMENT ON COLUMN lojas.pedidos.loja_id IS 'FK para a tabela lojas , atribui um ID para cada cliente';

CREATE TABLE lojas.pedidos_itens (

                pedido_id           NUMERIC(38) NOT NULL,

                produto_id          NUMERIC(38) NOT NULL,

                numero_da_linha     NUMERIC(38) NOT NULL,

                preco_unitario      NUMERIC(10,2) NOT NULL,

                quantidade          NUMERIC(38) NOT NULL,

                envio_id            NUMERIC(38),

                CONSTRAINT pedido_id_pfk PRIMARY KEY (pedido_id, produto_id)

);

COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela que armazena as informações importantes dos produtos para realizar o pedido';

COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'PFK da tabela pedidos_itens , que serve como FK para a tabela pedidos. Atribui um ID para cada pedido';

COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'PFK da tabela pedidos_itens , serve como FK para a tabela produtos. Atribui um ID para cada produto';

COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Linha de lançamento do produto';

COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço da unidade de cada produto';

COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade de unidades de um produto';

COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'FK para a tabela envios , atribui um ID para cada envio';

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION 
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
