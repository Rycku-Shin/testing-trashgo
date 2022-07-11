-- Database: trashgo

-- DROP DATABASE IF EXISTS trashgo;

CREATE DATABASE trashgo
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

    -- Table: public.admins

-- DROP TABLE IF EXISTS public.admins;

CREATE TABLE IF NOT EXISTS public.admins
(
    id_admin bigint NOT NULL DEFAULT nextval('admins_id_admin_seq'::regclass),
    email character varying(191) COLLATE pg_catalog."default",
    username text COLLATE pg_catalog."default",
    nama text COLLATE pg_catalog."default",
    password bytea,
    CONSTRAINT admins_pkey PRIMARY KEY (id_admin),
    CONSTRAINT admins_email_key UNIQUE (email)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.admins
    OWNER to postgres;

    -- Table: public.akun

-- DROP TABLE IF EXISTS public.akun;

CREATE TABLE IF NOT EXISTS public.akun
(
    "Id_akun" integer NOT NULL,
    "Id_admin" integer NOT NULL,
    id_supir integer NOT NULL,
    id_user bigint NOT NULL,
    CONSTRAINT akun_pkey PRIMARY KEY ("Id_akun")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.akun
    OWNER to postgres;
-- Index: akun_Id_Supir

-- DROP INDEX IF EXISTS public."akun_Id_Supir";

CREATE INDEX IF NOT EXISTS "akun_Id_Supir"
    ON public.akun USING btree
    (id_supir ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: akun_Id_User

-- DROP INDEX IF EXISTS public."akun_Id_User";

CREATE INDEX IF NOT EXISTS "akun_Id_User"
    ON public.akun USING btree
    (id_user ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: akun_Id_admin

-- DROP INDEX IF EXISTS public."akun_Id_admin";

CREATE INDEX IF NOT EXISTS "akun_Id_admin"
    ON public.akun USING btree
    ("Id_admin" ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.harga

-- DROP TABLE IF EXISTS public.harga;

CREATE TABLE IF NOT EXISTS public.harga
(
    id_harga integer NOT NULL DEFAULT nextval('harga_id_harga_seq'::regclass),
    harga_small integer NOT NULL,
    harga_medium integer NOT NULL,
    harga_large integer NOT NULL,
    harga_extra_large integer NOT NULL,
    CONSTRAINT harga_pkey PRIMARY KEY (id_harga)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.harga
    OWNER to postgres;

    -- Table: public.jalur

-- DROP TABLE IF EXISTS public.jalur;

CREATE TABLE IF NOT EXISTS public.jalur
(
    id_jalur integer NOT NULL DEFAULT nextval('jalur_id_jalur_seq'::regclass),
    data_jalur character varying(255) COLLATE pg_catalog."default" NOT NULL,
    id_komplek integer NOT NULL,
    CONSTRAINT jalur_pkey PRIMARY KEY (id_jalur),
    CONSTRAINT jalur_ibfk_1 FOREIGN KEY (id_komplek)
        REFERENCES public.komplek ("Id_komplek") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.jalur
    OWNER to postgres;
-- Index: jalur_data_jalur

-- DROP INDEX IF EXISTS public.jalur_data_jalur;

CREATE INDEX IF NOT EXISTS jalur_data_jalur
    ON public.jalur USING btree
    (data_jalur COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: jalur_id_komplek

-- DROP INDEX IF EXISTS public.jalur_id_komplek;

CREATE INDEX IF NOT EXISTS jalur_id_komplek
    ON public.jalur USING btree
    (id_komplek ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.kendaraan

-- DROP TABLE IF EXISTS public.kendaraan;

CREATE TABLE IF NOT EXISTS public.kendaraan
(
    "Id_kendaraan" integer NOT NULL,
    "Nomor_STNK" integer NOT NULL,
    "Plat_nomor" character varying(11) COLLATE pg_catalog."default" NOT NULL,
    "Jenis_kendaraan" character varying(11) COLLATE pg_catalog."default" NOT NULL,
    id_jalur integer NOT NULL,
    CONSTRAINT kendaraan_pkey PRIMARY KEY ("Id_kendaraan")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.kendaraan
    OWNER to postgres;
-- Index: kendaraan_id_jalur

-- DROP INDEX IF EXISTS public.kendaraan_id_jalur;

CREATE INDEX IF NOT EXISTS kendaraan_id_jalur
    ON public.kendaraan USING btree
    (id_jalur ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.komplek

-- DROP TABLE IF EXISTS public.komplek;

CREATE TABLE IF NOT EXISTS public.komplek
(
    "Id_komplek" integer NOT NULL DEFAULT nextval('"komplek_Id_komplek_seq"'::regclass),
    "Nama_komplek" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    penanggung_jawab character varying(220) COLLATE pg_catalog."default" NOT NULL,
    no_penanggung_jawab integer NOT NULL,
    "Alamat" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    id_user bigint NOT NULL,
    total_user_komplek integer NOT NULL,
    CONSTRAINT komplek_pkey PRIMARY KEY ("Id_komplek")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.komplek
    OWNER to postgres;
-- Index: komplek_Id_User

-- DROP INDEX IF EXISTS public."komplek_Id_User";

CREATE INDEX IF NOT EXISTS "komplek_Id_User"
    ON public.komplek USING btree
    (id_user ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: komplek_id_user_2

-- DROP INDEX IF EXISTS public.komplek_id_user_2;

CREATE INDEX IF NOT EXISTS komplek_id_user_2
    ON public.komplek USING btree
    (id_user ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.kota

-- DROP TABLE IF EXISTS public.kota;

CREATE TABLE IF NOT EXISTS public.kota
(
    id_kota integer NOT NULL DEFAULT nextval('kota_id_kota_seq'::regclass),
    nama_kota integer NOT NULL,
    jumlah_komplek integer NOT NULL,
    total_user_kota integer NOT NULL,
    id_komplek integer NOT NULL,
    CONSTRAINT kota_pkey PRIMARY KEY (id_kota)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.kota
    OWNER to postgres;
-- Index: kota_id_komplek

-- DROP INDEX IF EXISTS public.kota_id_komplek;

CREATE INDEX IF NOT EXISTS kota_id_komplek
    ON public.kota USING btree
    (id_komplek ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.laporans

-- DROP TABLE IF EXISTS public.laporans;

CREATE TABLE IF NOT EXISTS public.laporans
(
    id_laporan integer NOT NULL DEFAULT nextval('laporans_id_laporan_seq'::regclass),
    data_laporan character varying(255) COLLATE pg_catalog."default" NOT NULL,
    status_laporan_user character varying(11) COLLATE pg_catalog."default" NOT NULL,
    status_laporan_komplek character varying(11) COLLATE pg_catalog."default" NOT NULL,
    id_kota integer NOT NULL,
    id_jalur integer NOT NULL,
    tgl_laporan date,
    id_supir text COLLATE pg_catalog."default",
    id_komplek text COLLATE pg_catalog."default",
    id_kendaraan text COLLATE pg_catalog."default",
    CONSTRAINT laporans_pkey PRIMARY KEY (id_laporan)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.laporans
    OWNER to postgres;
-- Index: laporans_id_jalur

-- DROP INDEX IF EXISTS public.laporans_id_jalur;

CREATE INDEX IF NOT EXISTS laporans_id_jalur
    ON public.laporans USING btree
    (id_jalur ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: laporans_id_komplek

-- DROP INDEX IF EXISTS public.laporans_id_komplek;

CREATE INDEX IF NOT EXISTS laporans_id_komplek
    ON public.laporans USING btree
    (id_kota ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: laporans_tgl_laporan

-- DROP INDEX IF EXISTS public.laporans_tgl_laporan;

CREATE INDEX IF NOT EXISTS laporans_tgl_laporan
    ON public.laporans USING btree
    (tgl_laporan ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.login

-- DROP TABLE IF EXISTS public.login;

CREATE TABLE IF NOT EXISTS public.login
(
    "Riwaayat_login" timestamp without time zone NOT NULL,
    "Email" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "Password" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "Id_akun" integer NOT NULL,
    CONSTRAINT login_pkey PRIMARY KEY ("Riwaayat_login")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.login
    OWNER to postgres;
-- Index: login_Id_akun

-- DROP INDEX IF EXISTS public."login_Id_akun";

CREATE INDEX IF NOT EXISTS "login_Id_akun"
    ON public.login USING btree
    ("Id_akun" ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.rincian_laporan

-- DROP TABLE IF EXISTS public.rincian_laporan;

CREATE TABLE IF NOT EXISTS public.rincian_laporan
(
    data_laporan character varying(255) COLLATE pg_catalog."default" NOT NULL,
    status_laporan_kompleks character varying(255) COLLATE pg_catalog."default" NOT NULL,
    id_user bigint NOT NULL,
    id_admin integer NOT NULL,
    id_sampah integer NOT NULL,
    id_kota integer NOT NULL,
    tgl_laporan date NOT NULL,
    verifikkasi character varying(255) COLLATE pg_catalog."default" NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.rincian_laporan
    OWNER to postgres;
-- Index: rincian_laporan_id_admin

-- DROP INDEX IF EXISTS public.rincian_laporan_id_admin;

CREATE INDEX IF NOT EXISTS rincian_laporan_id_admin
    ON public.rincian_laporan USING btree
    (id_admin ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: rincian_laporan_id_kota

-- DROP INDEX IF EXISTS public.rincian_laporan_id_kota;

CREATE INDEX IF NOT EXISTS rincian_laporan_id_kota
    ON public.rincian_laporan USING btree
    (id_kota ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: rincian_laporan_id_sampah

-- DROP INDEX IF EXISTS public.rincian_laporan_id_sampah;

CREATE INDEX IF NOT EXISTS rincian_laporan_id_sampah
    ON public.rincian_laporan USING btree
    (id_sampah ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: rincian_laporan_id_user

-- DROP INDEX IF EXISTS public.rincian_laporan_id_user;

CREATE INDEX IF NOT EXISTS rincian_laporan_id_user
    ON public.rincian_laporan USING btree
    (id_user ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: rincian_laporan_tgl_laporan

-- DROP INDEX IF EXISTS public.rincian_laporan_tgl_laporan;

CREATE INDEX IF NOT EXISTS rincian_laporan_tgl_laporan
    ON public.rincian_laporan USING btree
    (tgl_laporan ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.riwayat_laporan

-- DROP TABLE IF EXISTS public.riwayat_laporan;

CREATE TABLE IF NOT EXISTS public.riwayat_laporan
(
    id_riwayat integer NOT NULL DEFAULT nextval('riwayat_laporan_id_riwayat_seq'::regclass),
    id_user integer NOT NULL,
    id_admin integer NOT NULL,
    id_supir integer NOT NULL,
    id_laporan integer NOT NULL,
    waktu_penjemputan character varying(255) COLLATE pg_catalog."default" NOT NULL,
    status_penjemputan character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT riwayat_laporan_pkey PRIMARY KEY (id_riwayat)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.riwayat_laporan
    OWNER to postgres;
-- Index: riwayat_laporan_id_laporan

-- DROP INDEX IF EXISTS public.riwayat_laporan_id_laporan;

CREATE INDEX IF NOT EXISTS riwayat_laporan_id_laporan
    ON public.riwayat_laporan USING btree
    (id_laporan ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.sampah

-- DROP TABLE IF EXISTS public.sampah;

CREATE TABLE IF NOT EXISTS public.sampah
(
    id_sampah integer NOT NULL DEFAULT nextval('sampah_id_sampah_seq'::regclass),
    id_kantong integer NOT NULL,
    id_user integer NOT NULL,
    CONSTRAINT sampah_pkey PRIMARY KEY (id_sampah)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sampah
    OWNER to postgres;
-- Index: sampah_id_kantong

-- DROP INDEX IF EXISTS public.sampah_id_kantong;

CREATE INDEX IF NOT EXISTS sampah_id_kantong
    ON public.sampah USING btree
    (id_kantong ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.supir

-- DROP TABLE IF EXISTS public.supir;

CREATE TABLE IF NOT EXISTS public.supir
(
    "Id_supir" integer NOT NULL DEFAULT nextval('"supir_Id_supir_seq"'::regclass),
    sim integer NOT NULL,
    "Id_kendaran" integer NOT NULL,
    CONSTRAINT supir_pkey PRIMARY KEY ("Id_supir")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.supir
    OWNER to postgres;
-- Index: supir_Id_kendaran

-- DROP INDEX IF EXISTS public."supir_Id_kendaran";

CREATE INDEX IF NOT EXISTS "supir_Id_kendaran"
    ON public.supir USING btree
    ("Id_kendaran" ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.tps

-- DROP TABLE IF EXISTS public.tps;

CREATE TABLE IF NOT EXISTS public.tps
(
    id_tps integer NOT NULL DEFAULT nextval('tps_id_tps_seq'::regclass),
    indikator_volume character varying(255) COLLATE pg_catalog."default" NOT NULL,
    status_jemput character varying(255) COLLATE pg_catalog."default" NOT NULL,
    lokasi character varying(255) COLLATE pg_catalog."default" NOT NULL,
    id_jalur integer NOT NULL,
    CONSTRAINT tps_pkey PRIMARY KEY (id_tps)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tps
    OWNER to postgres;
-- Index: tps_id_jalur

-- DROP INDEX IF EXISTS public.tps_id_jalur;

CREATE INDEX IF NOT EXISTS tps_id_jalur
    ON public.tps USING btree
    (id_jalur ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.ukuran_kantong

-- DROP TABLE IF EXISTS public.ukuran_kantong;

CREATE TABLE IF NOT EXISTS public.ukuran_kantong
(
    id_kantong integer NOT NULL DEFAULT nextval('ukuran_kantong_id_kantong_seq'::regclass),
    small integer NOT NULL,
    medium integer NOT NULL,
    extra_large integer NOT NULL,
    id_harga integer NOT NULL,
    CONSTRAINT ukuran_kantong_pkey PRIMARY KEY (id_kantong)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.ukuran_kantong
    OWNER to postgres;
-- Index: ukuran_kantong_id_harga

-- DROP INDEX IF EXISTS public.ukuran_kantong_id_harga;

CREATE INDEX IF NOT EXISTS ukuran_kantong_id_harga
    ON public.ukuran_kantong USING btree
    (id_harga ASC NULLS LAST)
    TABLESPACE pg_default;

    -- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id_user bigint NOT NULL DEFAULT nextval('users_id_user_seq'::regclass),
    email character varying(191) COLLATE pg_catalog."default",
    password bytea,
    username text COLLATE pg_catalog."default",
    call_number integer NOT NULL,
    address text COLLATE pg_catalog."default" NOT NULL,
    place_of_birth text COLLATE pg_catalog."default",
    gender text COLLATE pg_catalog."default",
    foto text COLLATE pg_catalog."default",
    title text COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id_user),
    CONSTRAINT users_email_key UNIQUE (email)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;