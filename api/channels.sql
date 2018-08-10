--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: tienson
--

CREATE TABLE channels (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    user_id uuid NOT NULL,
    is_private boolean DEFAULT false,
    need_invite boolean DEFAULT false,
    purpose text,
    members_count integer DEFAULT 0 NOT NULL,
    type text,
    picture text,
    block boolean DEFAULT false,
    locale text DEFAULT 'english'::text,
    created_at timestamp with time zone NOT NULL,
    CONSTRAINT created_at_chk CHECK ((date_part('timezone'::text, created_at) = '0'::double precision))
);


ALTER TABLE channels OWNER TO tienson;

--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: tienson
--

COPY channels (id, name, user_id, is_private, need_invite, purpose, members_count, type, picture, block, locale, created_at) FROM stdin;
978fccd9-1680-4d6e-910b-792b2d20ab23	Lym	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	lym	\N	f	english	2016-08-25 15:13:07.026+08
36c5bc48-ee8d-42ea-8a00-cb8bcd22d5da	Japanese	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	language	\N	f	english	2016-08-25 15:13:07.028+08
1dd7cc81-b4d2-4dbf-a756-4f77e952ab39	Dutch	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	language	\N	f	english	2016-08-25 15:13:07.031+08
0255c6b3-cff6-4e7d-9a5f-7327328f07ea	French	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	language	\N	f	english	2016-08-25 15:13:07.034+08
e024eb42-87ca-4442-82ea-47ebd82ed49b	Italian	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	language	\N	f	english	2016-08-25 15:13:07.037+08
dd840ca9-2cc2-431e-8b99-ce3e22515fcd	Chinese	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	language	\N	f	english	2016-08-25 15:13:07.039+08
1009f8cc-6a0b-49c3-bfd9-1332f3be4d45	Russian	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	language	\N	f	english	2016-08-25 15:13:07.04+08
fa663c9a-8c88-460b-8a40-2716083c3418	Spanish	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	language	\N	f	english	2016-08-25 15:13:07.043+08
8b4fb5a3-78cc-43ed-878a-435a3568bc1c	Portuguese	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	language	\N	f	english	2016-08-25 15:13:07.049+08
57def4fe-4aec-4646-ac02-51b5789c9517	Bangkok, Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bangkok-thailand-250px.jpg	f	english	2016-08-25 15:13:07.051+08
4e7055cd-e24d-4199-9a65-b844285c533c	Prague, Czech Republic	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/prague-czech-republic-250px.jpg	f	english	2016-08-25 15:13:07.053+08
4b0a24a7-6d76-4423-ae67-8621635e13eb	Las Palmas, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/las-palmas-gran-canaria-spain-250px.jpg	f	english	2016-08-25 15:13:07.055+08
71db8090-f944-4089-82e1-5ee5b2495cdd	Austin, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/austin-tx-united-states-250px.jpg	f	english	2016-08-25 15:13:07.058+08
5c7abe4d-b556-4b84-bb2d-4d6712cf2226	Tijuana, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tijuana-mexico-250px.jpg	f	english	2016-08-25 15:13:07.062+08
380596c2-6fbb-4f4f-bc22-061104a71e6a	Porto, Portugal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/porto-portugal-250px.jpg	f	english	2016-08-25 15:13:07.064+08
e56fada4-e4ab-47d0-b1cb-195acfb344c6	Taipei, Taiwan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/taipei-taiwan-250px.jpg	f	english	2016-08-25 15:13:07.068+08
bb10adb6-393c-4755-8d96-abccd56eaed8	Portland, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/portland-or-united-states-250px.jpg	f	english	2016-08-25 15:13:07.07+08
9e7a01eb-9088-4476-88d8-30e2d3e68fcf	Budapest, Hungary	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/budapest-hungary-250px.jpg	f	english	2016-08-25 15:13:07.077+08
31f23aac-f770-4f69-842a-91d4d35c3820	San Jose, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/san-jose-ca-united-states-250px.jpg	f	english	2016-08-25 15:13:07.08+08
67da3f4b-c39a-4a7f-bc0a-4986c34cef66	Atlanta, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/atlanta-ga-united-states-250px.jpg	f	english	2016-08-25 15:13:07.083+08
173d65c2-52db-4438-9bee-541284c39211	Miami, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/miami-fl-united-states-250px.jpg	f	english	2016-08-25 15:13:07.085+08
c644a84d-38ee-459e-8837-57956cf6712e	San Diego, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/san-diego-ca-united-states-250px.jpg	f	english	2016-08-25 15:13:07.087+08
86b0e735-2d15-453f-ba69-114697b291fd	Minneapolis, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/minneapolis-mn-united-states-250px.jpg	f	english	2016-08-25 15:13:07.088+08
fcd503bd-37cf-4f5a-b588-e6ddbfe6665d	Madrid, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/madrid-spain-250px.jpg	f	english	2016-08-25 15:13:07.091+08
e68caf37-1b3e-47c1-84f9-7bd30cf84ab7	Stockholm, Sweden	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/stockholm-sweden-250px.jpg	f	english	2016-08-25 15:13:07.092+08
b059b3e1-6113-421f-9b5f-a7a884958f78	Leiden, Netherlands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/leiden-netherlands-250px.jpg	f	english	2016-08-25 15:13:07.093+08
0898af4e-c7f3-430a-b936-07e0b1455bc2	Wellington, New Zealand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/wellington-new-zealand-250px.jpg	f	english	2016-08-25 15:13:07.094+08
ebd1103e-4b73-4404-84bd-f8c40e8552e4	Rotterdam, Netherlands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/rotterdam-netherlands-250px.jpg	f	english	2016-08-25 15:13:07.094+08
99a485c9-98d2-4ef4-9634-eefdd753562a	Colorado Springs, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/colorado-springs-co-united-states-250px.jpg	f	english	2016-08-25 15:13:07.095+08
80d50317-d4ed-4122-80b5-8b1c2d68c57a	Chiang Mai, Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chiang-mai-thailand-250px.jpg	f	english	2016-08-25 15:13:07.096+08
4a030013-a3a9-41f6-a3b6-a1e3c75433e5	Madison, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/madison-wi-united-states-250px.jpg	f	english	2016-08-25 15:13:07.097+08
9816e596-06cd-4341-bfce-09e01331e1f1	Cincinnati, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cincinnati-oh-united-states-250px.jpg	f	english	2016-08-25 15:13:07.099+08
136f9778-8d8b-437f-b284-226dbbfd23b8	Montreal, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/montreal-canada-250px.jpg	f	english	2016-08-25 15:13:07.1+08
fa9fc698-3f00-4bab-b834-718e96c14c8d	Grand Rapids, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/grand-rapids-mi-united-states-250px.jpg	f	english	2016-08-25 15:13:07.101+08
a7ce876e-8a4b-4d0a-b965-7cd48924e2e1	Jacksonville, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jacksonville-fl-united-states-250px.jpg	f	english	2016-08-25 15:13:07.102+08
b7a26ead-c1c8-406d-a9fd-a5b106846210	Bern, Switzerland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bern-switzerland-250px.jpg	f	english	2016-08-25 15:13:07.103+08
09ee3190-3c84-4f90-b25c-08ca0e93235a	Albuquerque, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/albuquerque-nm-united-states-250px.jpg	f	english	2016-08-25 15:13:07.104+08
57563086-6f6d-4f59-9fe9-fe60a1e4a264	Ubud, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ubud-bali-indonesia-250px.jpg	f	english	2016-08-25 15:13:07.106+08
73baa882-b2e3-435e-904d-cf35a82e61ed	The Hague, Netherlands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/the-hague-netherlands-250px.jpg	f	english	2016-08-25 15:13:07.109+08
fef61416-6cf0-4cfb-9f89-cdebbb0283ed	Pittsburgh, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/pittsburgh-pa-united-states-250px.jpg	f	english	2016-08-25 15:13:07.109+08
269bc816-e517-43e4-a7c6-d58272d44664	Ko Samui, Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ko-samui-thailand-250px.jpg	f	english	2016-08-25 15:13:07.11+08
17b3a989-6cc6-4567-b597-ebc4369cbca0	Brussels, Belgium	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/brussels-belgium-250px.jpg	f	english	2016-08-25 15:13:07.111+08
f25316c0-ccfc-487f-b781-95773075fd1f	Nashville, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nashville-tn-united-states-250px.jpg	f	english	2016-08-25 15:13:07.112+08
98bee54a-0d1a-467b-959b-7afdb498b84f	Houston, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/houston-tx-united-states-250px.jpg	f	english	2016-08-25 15:13:07.113+08
5b98a5c6-6a4c-41bb-a680-b98bb627fae7	Tea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	english	2016-08-25 15:13:12.841+08
b8aac35d-df7d-4493-81ec-7d85b0483247	Charlotte, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/charlotte-nc-united-states-250px.jpg	f	english	2016-08-25 15:13:07.114+08
9c56e84d-c93c-4be3-b859-1a9d8d4c0970	Kansas City, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kansas-city-mo-united-states-250px.jpg	f	english	2016-08-25 15:13:07.116+08
a2b2ee31-3236-4b4b-88db-0d7ddd260c13	Munich, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/munich-germany-250px.jpg	f	english	2016-08-25 15:13:07.117+08
5f232899-f5fa-4804-a72b-ea826bb60941	Phoenix, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/phoenix-az-united-states-250px.jpg	f	english	2016-08-25 15:13:07.118+08
4d86d370-85e8-4506-b238-12344b19c7b6	Denver, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/denver-co-united-states-250px.jpg	f	english	2016-08-25 15:13:07.119+08
34633534-e341-43f8-9397-26c774cb5616	Windsor, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/windsor-canada-250px.jpg	f	english	2016-08-25 15:13:07.12+08
a7479204-a804-4c49-8ea3-0a2fe38f08cc	Las Vegas, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/las-vegas-nv-united-states-250px.jpg	f	english	2016-08-25 15:13:07.121+08
39c76909-6374-4c06-8db2-7d2d1b67e426	Buffalo, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/buffalo-ny-united-states-250px.jpg	f	english	2016-08-25 15:13:07.123+08
33e13530-cf26-4648-91e7-053a3007f710	Dallas, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dallas-tx-united-states-250px.jpg	f	english	2016-08-25 15:13:07.124+08
e1fed24a-3dac-42ea-b288-3fae924ac31a	Louisville, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/louisville-ky-united-states-250px.jpg	f	english	2016-08-25 15:13:07.126+08
c3f32382-f4ee-43bf-84e8-504f2ab7b2e9	Phuket, Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/phuket-thailand-250px.jpg	f	english	2016-08-25 15:13:07.127+08
26d830d0-ab1c-4e26-9bbf-9d40e169bfb1	Gurgaon, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/gurgaon-india-250px.jpg	f	english	2016-08-25 15:13:07.128+08
38be2ab8-235e-4a8d-bedc-71d0db3afd0d	Cordoba, Argentina	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cordoba-argentina-250px.jpg	f	english	2016-08-25 15:13:07.129+08
e99292fc-f86e-48a0-b76e-110b5670c6a0	Rochester, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/rochester-ny-united-states-250px.jpg	f	english	2016-08-25 15:13:07.13+08
6a2be253-4a3e-46a8-bc80-a5e8a841a30e	Stuttgart, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/stuttgart-germany-250px.jpg	f	english	2016-08-25 15:13:07.131+08
957c2f40-03d6-44a7-b356-f17220423c55	Cluj, Romania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cluj-romania-250px.jpg	f	english	2016-08-25 15:13:07.132+08
6fa1d478-cf3c-4f82-b8cf-8940d4534020	Raleigh, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/raleigh-nc-united-states-250px.jpg	f	english	2016-08-25 15:13:07.132+08
2c404a0d-3867-44c9-b4f7-8e0fb8d5cbe5	Norfolk, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/norfolk-va-united-states-250px.jpg	f	english	2016-08-25 15:13:07.133+08
79f0696d-f57a-4964-81a5-211c8554c162	Ho Chi Minh City, Vietnam	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ho-chi-minh-city-vietnam-250px.jpg	f	english	2016-08-25 15:13:07.134+08
3ea9a49a-95e7-4d36-b8f6-b8b290c6f94e	Charleston, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/charleston-sc-united-states-250px.jpg	f	english	2016-08-25 15:13:07.135+08
12bb3078-d2df-4d60-818a-f88ada063624	Ghent, Belgium	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ghent-belgium-250px.jpg	f	english	2016-08-25 15:13:07.136+08
2ada61bc-f0f0-4690-82a5-72707690692d	Nuremberg, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nuremberg-germany-250px.jpg	f	english	2016-08-25 15:13:07.137+08
31616163-c2d1-4d70-9e6f-b4e45e6cbf05	St. Louis, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/st-louis-mo-united-states-250px.jpg	f	english	2016-08-25 15:13:07.138+08
40e4319f-6dd5-4ef1-94da-ac51ecb49f56	Seoul, South Korea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/seoul-south-korea-250px.jpg	f	english	2016-08-25 15:13:07.139+08
415e7f3a-d776-4e9d-8411-955f313e0a56	Tampa, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tampa-fl-united-states-250px.jpg	f	english	2016-08-25 15:13:07.14+08
991e7bab-3c06-46f5-9d79-1cf269e79a3e	Lille, France	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lille-france-250px.jpg	f	english	2016-08-25 15:13:07.14+08
0de623d0-932e-44fc-8275-9644a7957324	Tallinn, Estonia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tallinn-estonia-250px.jpg	f	english	2016-08-25 15:13:07.142+08
80aff310-a002-46ca-91b1-5a3591d0535f	Canggu, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/canggu-bali-indonesia-250px.jpg	f	english	2016-08-25 15:13:07.142+08
4c2b4f2d-5355-4900-9b5e-b291d83be817	San Antonio, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/san-antonio-tx-united-states-250px.jpg	f	english	2016-08-25 15:13:07.144+08
0e4c584d-169e-4d4c-8984-b14f87662141	Perth, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/perth-australia-250px.jpg	f	english	2016-08-25 15:13:07.146+08
74706d77-78eb-42ef-bbbc-eb9691e99d02	Hamburg, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hamburg-germany-250px.jpg	f	english	2016-08-25 15:13:07.147+08
0590c69a-9be4-475c-b55e-61546be7d613	Yerevan, Armenia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/yerevan-armenia-250px.jpg	f	english	2016-08-25 15:13:07.147+08
397f6b60-4e26-484d-ae09-bafd09af8427	Surrey, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/surrey-canada-250px.jpg	f	english	2016-08-25 15:13:07.148+08
49e46798-b47f-4c7a-b095-640dce449979	Philadelphia, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/philadelphia-pa-united-states-250px.jpg	f	english	2016-08-25 15:13:07.149+08
24966a9c-8a23-473d-b732-2bb4b4f31150	Seattle, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/seattle-wa-united-states-250px.jpg	f	english	2016-08-25 15:13:07.15+08
7690056b-cbaa-449b-b343-51e41002bfb4	Adelaide, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/adelaide-australia-250px.jpg	f	english	2016-08-25 15:13:07.151+08
9fcbead6-e5a1-4712-9997-b3a084e64e02	Milwaukee, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/milwaukee-wi-united-states-250px.jpg	f	english	2016-08-25 15:13:07.152+08
a8f4533e-9fc7-42a1-976b-470dde0c9ad3	New Orleans, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/new-orleans-la-united-states-250px.jpg	f	english	2016-08-25 15:13:07.153+08
2c034cd1-b01a-4ba4-96e2-464f4e1b5765	Vienna, Austria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/vienna-austria-250px.jpg	f	english	2016-08-25 15:13:07.154+08
6c987bce-5add-41c2-ad97-19698b5f429d	Boulder, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/boulder-co-united-states-250px.jpg	f	english	2016-08-25 15:13:07.155+08
d959cebf-09cc-4e6c-834b-7699582f8c50	Oslo, Norway	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/oslo-norway-250px.jpg	f	english	2016-08-25 15:13:07.156+08
020346aa-6645-4d28-b2d3-64dd066677f2	Cameroon	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cm.png	f	english	2016-08-25 15:13:10.421+08
be47bed7-a764-40b8-89fb-dbb96a3071f7	Christchurch, New Zealand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/christchurch-new-zealand-250px.jpg	f	english	2016-08-25 15:13:07.157+08
6d9fe28d-5afd-416b-97e4-52fbd9158e6f	Quebec City, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/quebec-city-canada-250px.jpg	f	english	2016-08-25 15:13:07.158+08
dba6631a-22c1-45e4-8298-ac3b31fb5e46	Athens, Greece	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/athens-greece-250px.jpg	f	english	2016-08-25 15:13:07.159+08
e95890c0-01f1-4180-8399-dc96914927ad	Riga, Latvia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/riga-latvia-250px.jpg	f	english	2016-08-25 15:13:07.16+08
444d3ecc-e7ce-4c4a-8bde-aa751a459043	Belgrade, Serbia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/belgrade-serbia-250px.jpg	f	english	2016-08-25 15:13:07.161+08
5a36c832-9596-4d30-abf7-8552750643cd	Cologne, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cologne-germany-250px.jpg	f	english	2016-08-25 15:13:07.162+08
99e18005-bf1b-4b92-8e86-a099bf4b51a8	Basel, Switzerland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/basel-switzerland-250px.jpg	f	english	2016-08-25 15:13:07.163+08
f53f1725-a094-4999-8784-2e8ce87cb41b	Antwerp, Belgium	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/antwerp-belgium-250px.jpg	f	english	2016-08-25 15:13:07.164+08
db852558-8f81-430f-9434-93b3443a4e97	Groningen, Netherlands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/groningen-netherlands-250px.jpg	f	english	2016-08-25 15:13:07.165+08
c2c08fe8-228f-4f15-a0a0-18b91b4c7289	Fort Lauderdale, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/fort-lauderdale-fl-united-states-250px.jpg	f	english	2016-08-25 15:13:07.166+08
377aaec1-df85-49bb-9d16-78dd4a4cbcc4	Utrecht, Netherlands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/utrecht-netherlands-250px.jpg	f	english	2016-08-25 15:13:07.167+08
45e6c434-4c53-484e-bccb-e6770fdf4bc2	Kiev, Ukraine	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kiev-ukraine-250px.jpg	f	english	2016-08-25 15:13:07.168+08
6b0071d4-89bc-4adb-94cf-79b715d5bb0a	Bellingham, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bellingham-wa-united-states-250px.jpg	f	english	2016-08-25 15:13:07.169+08
d841cd37-8d53-47da-8eb7-6041e8c7aaf9	Liverpool, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/liverpool-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.171+08
379859a5-0bef-4515-8eab-c66e64f347f1	Valencia, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/valencia-spain-250px.jpg	f	english	2016-08-25 15:13:07.173+08
902125f4-5f8a-4a8d-98f5-4ce0655f9213	Cleveland, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cleveland-oh-united-states-250px.jpg	f	english	2016-08-25 15:13:07.174+08
4f7a9a11-0fed-4b94-8088-29f8be13cf90	Sacramento, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/sacramento-ca-united-states-250px.jpg	f	english	2016-08-25 15:13:07.175+08
8ecadf84-7ac4-4071-94c0-25b3dc2a2510	Kitchener, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kitchener-canada-250px.jpg	f	english	2016-08-25 15:13:07.176+08
ce6df459-83dc-433f-9336-9757e53a7428	Indianapolis, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/indianapolis-in-united-states-250px.jpg	f	english	2016-08-25 15:13:07.177+08
cb0eb62b-507a-43eb-8e13-a867e1a0f533	Halifax, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/halifax-canada-250px.jpg	f	english	2016-08-25 15:13:07.178+08
51913d76-eb00-4995-aa3d-6b40be85683d	Tucson, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tucson-az-united-states-250px.jpg	f	english	2016-08-25 15:13:07.179+08
a0931110-8c6c-47b1-ad23-4f2edbec52ec	Buenos Aires, Argentina	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/buenos-aires-argentina-250px.jpg	f	english	2016-08-25 15:13:07.179+08
0341ac16-7700-4a33-88b8-8393b51a2872	Wrocław, Poland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/wroclaw-poland-250px.jpg	f	english	2016-08-25 15:13:07.18+08
10d81756-13e4-4b92-a667-40f9e0c5f52b	Warsaw, Poland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/warsaw-poland-250px.jpg	f	english	2016-08-25 15:13:07.181+08
64ae5a55-44e5-45bc-9b7a-7627d5b89a05	Hanoi, Vietnam	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hanoi-vietnam-250px.jpg	f	english	2016-08-25 15:13:07.182+08
856995a4-877d-476c-a668-dd52afc565ff	Nice, France	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nice-france-250px.jpg	f	english	2016-08-25 15:13:07.183+08
8e6747d6-7f5c-43a8-860a-5193032ee9e1	Yokohama, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/yokohama-japan-250px.jpg	f	english	2016-08-25 15:13:07.184+08
162c2a61-1f42-4bef-8851-767d40c4b1f5	Quito, Ecuador	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/quito-ecuador-250px.jpg	f	english	2016-08-25 15:13:07.185+08
5997e8f3-7806-4d94-8773-0a1b9333c319	Bordeaux, France	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bordeaux-france-250px.jpg	f	english	2016-08-25 15:13:07.187+08
8aff7ac4-5c7f-48da-b50b-90e4f6f868d8	Busan, South Korea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/busan-south-korea-250px.jpg	f	english	2016-08-25 15:13:07.188+08
b62d7a40-3228-4675-bfce-61b3deef5528	Lyon, France	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lyon-france-250px.jpg	f	english	2016-08-25 15:13:07.189+08
e3516085-5923-445b-a249-0dfe6ba9773c	Stamford, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/stamford-ct-united-states-250px.jpg	f	english	2016-08-25 15:13:07.19+08
7fedc21a-8455-4074-8644-9f35f9a9ce7c	Berlin, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/berlin-germany-250px.jpg	f	english	2016-08-25 15:13:07.191+08
2af700b3-bd65-43a9-9de5-5ab15d4442c1	Sao Paulo, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/sao-paulo-brazil-250px.jpg	f	english	2016-08-25 15:13:07.192+08
7514c6ae-517e-4f79-b0ff-d8b2b8d70d8a	Eindhoven, Netherlands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/eindhoven-netherlands-250px.jpg	f	english	2016-08-25 15:13:07.193+08
75a2e995-0374-4053-802e-f7e359512af0	Bristol, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bristol-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.194+08
1d73c20d-5a1e-4370-9ef4-0b2b2a57e8b0	Salt Lake City, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/salt-lake-city-ut-united-states-250px.jpg	f	english	2016-08-25 15:13:07.195+08
7a43b1a3-221d-4a7f-9cb8-dce0ca5a0e18	Richmond, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/richmond-va-united-states-250px.jpg	f	english	2016-08-25 15:13:07.196+08
fbdc5b16-50b0-4eee-8088-13690b4e6c76	Hong Kong, Hong Kong	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hong-kong-hong-kong-250px.jpg	f	english	2016-08-25 15:13:07.197+08
7f96d4b7-844e-40ae-9340-4718e27189ca	Victoria, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/victoria-canada-250px.jpg	f	english	2016-08-25 15:13:07.198+08
f31533a5-c853-4a15-bd5c-5fd3c284b211	Osaka, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/osaka-japan-250px.jpg	f	english	2016-08-25 15:13:07.199+08
d3dd1002-18cd-42dc-a1a3-9cf952dd5620	Minsk, Belarus	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/minsk-belarus-250px.jpg	f	english	2016-08-25 15:13:07.199+08
eb570d21-7457-47d8-a5dc-cf747ba9fbfb	吃	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	chinese	2016-08-25 15:13:12.844+08
15691e73-67f9-4de8-8688-5038309a5a0a	Bratislava, Slovakia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bratislava-slovakia-250px.jpg	f	english	2016-08-25 15:13:07.201+08
18f5f3a5-9478-44db-9950-87116b73daed	Playa del Carmen, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/playa-del-carmen-mexico-250px.jpg	f	english	2016-08-25 15:13:07.202+08
915fe125-0d2a-47ef-9d64-03a1be390bc2	Jena, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jena-germany-250px.jpg	f	english	2016-08-25 15:13:07.203+08
47574bee-7d9c-47bd-97c0-e46bf4ca9a83	Manchester, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/manchester-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.204+08
c35eecc1-c14c-44c4-8994-1f05e573cfbb	Cancun, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cancun-mexico-250px.jpg	f	english	2016-08-25 15:13:07.205+08
9a9ac06b-1f5d-467e-b0d9-f3cd17a462c9	Lublin, Poland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lublin-poland-250px.jpg	f	english	2016-08-25 15:13:07.206+08
fdf83fbb-59ab-4f65-bf48-c13a8fe19da9	Jeju Island, South Korea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jeju-island-south-korea-250px.jpg	f	english	2016-08-25 15:13:07.207+08
ce9d29e5-6971-4fc2-845a-bbec8117b34b	Park City, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/park-city-ut-united-states-250px.jpg	f	english	2016-08-25 15:13:07.208+08
83ad8aaf-65a4-46d8-b1de-65e2ab7b479d	Honolulu, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/honolulu-hawaii-united-states-250px.jpg	f	english	2016-08-25 15:13:07.209+08
b6238e25-d708-426f-9116-240e366dda69	Marseille, France	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/marseille-france-250px.jpg	f	english	2016-08-25 15:13:07.21+08
c5e20cb9-c8fa-4645-9d61-f8667b159abc	Braga, Portugal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/braga-portugal-250px.jpg	f	english	2016-08-25 15:13:07.212+08
4832bd6d-0d96-43c4-a326-ba3f47932b28	Daegu, South Korea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/daegu-south-korea-250px.jpg	f	english	2016-08-25 15:13:07.213+08
f2094059-e48b-4d4f-89bc-a2bfa026a032	Columbus, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/columbus-oh-united-states-250px.jpg	f	english	2016-08-25 15:13:07.214+08
3d9849fc-c1d9-40a1-9df3-5b8d1a2c644e	Ottawa, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ottawa-canada-250px.jpg	f	english	2016-08-25 15:13:07.215+08
fd3af2b0-405e-4524-912a-3ddcd90e2ff2	Nottingham, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nottingham-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.216+08
64246054-f3a1-4251-8159-99d000b16b69	Natal, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/natal-brazil-250px.jpg	f	english	2016-08-25 15:13:07.217+08
4c38fc6f-bf3a-4fcb-b5d2-1702e205e4c4	Leipzig, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/leipzig-germany-250px.jpg	f	english	2016-08-25 15:13:07.218+08
7f77f6af-369b-4c17-a1b9-82f66d3911e5	Kraków, Poland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/krakow-poland-250px.jpg	f	english	2016-08-25 15:13:07.218+08
50fb7ddc-5c5e-4152-bdc5-7c5b22ecea6c	Aveiro, Portugal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/aveiro-portugal-250px.jpg	f	english	2016-08-25 15:13:07.219+08
b81f1d97-e42a-439b-8586-7c5fef5579a6	Lviv, Ukraine	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lviv-ukraine-250px.jpg	f	english	2016-08-25 15:13:07.221+08
dfde6d16-b545-4b2f-a08b-a1cc2cf7603b	Knoxville, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/knoxville-tn-united-states-250px.jpg	f	english	2016-08-25 15:13:07.222+08
10e786c1-3546-4276-b45c-25a41670e321	Kosice, Slovakia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kosice-slovakia-250px.jpg	f	english	2016-08-25 15:13:07.223+08
2429cab1-7a6f-4511-b791-8931460f09e1	Funchal, Portugal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/funchal-portugal-250px.jpg	f	english	2016-08-25 15:13:07.224+08
9f726af0-b022-48dd-8077-7672af6fa053	Brisbane, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/brisbane-australia-250px.jpg	f	english	2016-08-25 15:13:07.225+08
b42528a4-99b0-4461-a6f6-b6fee6b1b20c	Novi Sad, Serbia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/novi-sad-serbia-250px.jpg	f	english	2016-08-25 15:13:07.226+08
e7b65f71-144c-4763-b3d7-d38ada83e5df	Ko Lanta, Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ko-lanta-thailand-250px.jpg	f	english	2016-08-25 15:13:07.227+08
26de1742-f3d5-45d2-9d62-058f1b190043	Sofia, Bulgaria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/sofia-bulgaria-250px.jpg	f	english	2016-08-25 15:13:07.228+08
f290f2a0-413c-4f11-a427-20eda76bab32	Leicester, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/leicester-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.229+08
652ce712-d793-469e-98c4-69f6aa21e408	Chennai, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chennai-india-250px.jpg	f	english	2016-08-25 15:13:07.23+08
d7afb64c-6e9b-437d-927f-651bdc3ade25	Padova, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/padova-italy-250px.jpg	f	english	2016-08-25 15:13:07.231+08
f27b9477-87ac-4f33-958e-60e1493f6b56	Beacon, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/beacon-ny-united-states-250px.jpg	f	english	2016-08-25 15:13:07.232+08
894322a9-25f5-49aa-9e8f-77737d220e87	Orlando, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/orlando-fl-united-states-250px.jpg	f	english	2016-08-25 15:13:07.233+08
ab2db7b2-44ea-4608-9fab-5197e18449fb	Lisbon, Portugal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lisbon-portugal-250px.jpg	f	english	2016-08-25 15:13:07.234+08
917c4ef4-9c17-473a-b7d8-da93a9e5ed02	Szczecin, Poland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/szczecin-poland-250px.jpg	f	english	2016-08-25 15:13:07.235+08
da7e4f01-3f51-49c3-94c0-c12e7d1f61ec	Edinburgh, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/edinburgh-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.236+08
c17d55f2-7130-47e4-915e-1136758c4eca	Wollongong, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/wollongong-australia-250px.jpg	f	english	2016-08-25 15:13:07.236+08
edffe98f-bb38-41c2-848f-d4a40a0fb700	Skopje, Macedonia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/skopje-macedonia-250px.jpg	f	english	2016-08-25 15:13:07.237+08
6a88a289-4590-440c-b728-e77a2a93a007	Memphis, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/memphis-tn-united-states-250px.jpg	f	english	2016-08-25 15:13:07.238+08
148f4d39-41cc-4ccf-bb39-06fa1958c02f	Ljubljana, Slovenia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ljubljana-slovenia-250px.jpg	f	english	2016-08-25 15:13:07.239+08
06237997-714f-42c7-90d3-4099d480828d	Denpasar, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/denpasar-bali-indonesia-250px.jpg	f	english	2016-08-25 15:13:07.24+08
ceb76feb-7576-4a7e-a7ae-616726b4b8a9	Tokyo, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tokyo-japan-250px.jpg	f	english	2016-08-25 15:13:07.241+08
5c1a9a1f-ae51-4b97-8972-36303beceb02	Pisa, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/pisa-italy-250px.jpg	f	english	2016-08-25 15:13:07.241+08
56e567c4-d92a-4f99-b5c6-2a654b3d23c4	手艺	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	chinese	2016-08-25 15:13:12.846+08
1dd954b2-3f72-4012-aa0f-c1cb4a0468b1	Thessaloniki, Greece	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/thessaloniki-greece-250px.jpg	f	english	2016-08-25 15:13:07.242+08
d3c71a4f-29ef-4983-8fd6-919fd93a9c51	Oklahoma City, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/oklahoma-city-ok-united-states-250px.jpg	f	english	2016-08-25 15:13:07.243+08
de22201e-3570-479c-aa28-917dc9378dba	Toulouse, France	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/toulouse-france-250px.jpg	f	english	2016-08-25 15:13:07.244+08
01007e77-efad-46f7-8ead-54729509e5f8	Auckland, New Zealand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/auckland-new-zealand-250px.jpg	f	english	2016-08-25 15:13:07.245+08
1aa79c21-02a9-4d6f-ada8-4ca4707c4bfc	Oulu, Finland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/oulu-finland-250px.jpg	f	english	2016-08-25 15:13:07.246+08
e2df851d-4f07-4760-8234-9c53e01e130c	Brasov, Romania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/brasov-romania-250px.jpg	f	english	2016-08-25 15:13:07.247+08
1fc56a73-fde7-472c-a967-893a36a95d42	Baltimore, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/baltimore-md-united-states-250px.jpg	f	english	2016-08-25 15:13:07.248+08
0dd5e330-fd3c-412b-9500-5fad12051f8c	Karlsruhe, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/karlsruhe-germany-250px.jpg	f	english	2016-08-25 15:13:07.249+08
c8d10592-c453-4960-ac95-126793d3088d	Tartu, Estonia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tartu-estonia-250px.jpg	f	english	2016-08-25 15:13:07.25+08
b2f2ebba-3413-4301-a232-06b651374c77	Des Moines, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/des-moines-ia-united-states-250px.jpg	f	english	2016-08-25 15:13:07.251+08
655615e3-8127-423e-b9d2-cea0d7bb45e4	West Palm Beach, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/west-palm-beach-fl-united-states-250px.jpg	f	english	2016-08-25 15:13:07.252+08
2d97e52c-4115-49e6-b768-e69f79bad05e	Cairns, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cairns-australia-250px.jpg	f	english	2016-08-25 15:13:07.253+08
f2c070ff-977a-471e-854e-a786b7f613c7	Patras, Greece	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/patras-greece-250px.jpg	f	english	2016-08-25 15:13:07.254+08
b06d50a9-4635-4e3c-a08b-7261738f1bc4	Corralejo, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/corralejo-fuerteventura-spain-250px.jpg	f	english	2016-08-25 15:13:07.255+08
de249e03-6111-4ad4-895e-44f2aaaca163	Palma De Mallorca, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/palma-de-mallorca-spain-250px.jpg	f	english	2016-08-25 15:13:07.256+08
99a1223f-33e7-4202-9f62-69db72bafb3b	Shenzhen, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/shenzhen-china-250px.jpg	f	english	2016-08-25 15:13:07.257+08
cc9d6992-bf58-4250-acd9-6cc2d1e82c99	Bremen, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bremen-germany-250px.jpg	f	english	2016-08-25 15:13:07.258+08
3df6ab7d-5e10-4ef6-838e-46ec0553b6dd	Provo, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/provo-ut-united-states-250px.jpg	f	english	2016-08-25 15:13:07.259+08
d3a8a86b-ce9f-4216-8f03-e42a044c8662	Calgary, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/calgary-canada-250px.jpg	f	english	2016-08-25 15:13:07.26+08
b841fe10-c723-4cbc-9b5c-a84abf5312c4	Glasgow, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/glasgow-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.261+08
c3d9a83d-fc02-4532-8c73-dd89ff50fe9a	Oshawa, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/oshawa-canada-250px.jpg	f	english	2016-08-25 15:13:07.262+08
10b9501d-cd07-4040-8d1b-652ca6b29b40	Ann Arbor, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ann-arbor-mi-united-states-250px.jpg	f	english	2016-08-25 15:13:07.263+08
1aefa436-1c7f-44ca-ba69-6efc580e7ab8	Chattanooga, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chattanooga-tn-united-states-250px.jpg	f	english	2016-08-25 15:13:07.264+08
828b62e3-a224-49c2-8c54-7486bc50fc7e	Zadar, Croatia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/zadar-croatia-250px.jpg	f	english	2016-08-25 15:13:07.266+08
b91f6a76-de1f-4d01-8533-cc7a933a2ade	Ogden, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ogden-ut-united-states-250px.jpg	f	english	2016-08-25 15:13:07.267+08
5dc36f00-bfcb-45c5-8f2c-6ac88b6f779c	Hartford, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hartford-ct-united-states-250px.jpg	f	english	2016-08-25 15:13:07.268+08
9db3953c-c0bd-417e-b8e1-6ea216e16371	Brighton, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/brighton-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.269+08
a88d7201-61eb-4eae-af8c-71358a31c4d3	Varna, Bulgaria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/varna-bulgaria-250px.jpg	f	english	2016-08-25 15:13:07.27+08
f42d9164-0f38-4cd1-8a57-1f3978d73cad	Trento, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/trento-italy-250px.jpg	f	english	2016-08-25 15:13:07.271+08
bc2e7cc9-edb3-4359-b0b8-545fb8216962	Montevideo, Uruguay	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/montevideo-uruguay-250px.jpg	f	english	2016-08-25 15:13:07.272+08
075e79e6-e74a-44f8-b07a-77b504c1f271	Shanghai, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/shanghai-china-250px.jpg	f	english	2016-08-25 15:13:07.272+08
d546e282-e0b0-4ee8-ac9e-475c3235bbb6	Nis, Serbia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nis-serbia-250px.jpg	f	english	2016-08-25 15:13:07.273+08
0d3840de-3fe3-4918-9bc8-b920b5751320	Daejeon, South Korea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/daejeon-south-korea-250px.jpg	f	english	2016-08-25 15:13:07.274+08
7458d2b5-eab2-49f0-98f4-17fbff2f96c7	Dusseldorf, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dusseldorf-germany-250px.jpg	f	english	2016-08-25 15:13:07.275+08
89d570cf-f79a-4ba1-9484-c0b580e57273	Novosibirsk, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/novosibirsk-russia-250px.jpg	f	english	2016-08-25 15:13:07.277+08
ef798304-6be8-443c-824f-1e32f4a8922d	Timisoara, Romania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/timisoara-romania-250px.jpg	f	english	2016-08-25 15:13:07.278+08
486fb744-4450-4c55-a3d6-28f225bdd975	Fairfax, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/fairfax-va-united-states-250px.jpg	f	english	2016-08-25 15:13:07.279+08
99ba2c77-35bb-4bf3-ac53-afee235db1c2	Espoo, Finland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/espoo-finland-250px.jpg	f	english	2016-08-25 15:13:07.279+08
53474e5e-40ca-458f-940b-f47bf029c293	Newcastle Upon Tyne, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/newcastle-upon-tyne-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.281+08
a14f67cc-585e-4529-b5a8-7650fca18a3f	Bilbao, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bilbao-spain-250px.jpg	f	english	2016-08-25 15:13:07.282+08
a447b484-b7f8-4a7e-a554-8c0a55367f6c	Trondheim, Norway	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/trondheim-norway-250px.jpg	f	english	2016-08-25 15:13:07.282+08
17343911-0241-4f00-952e-a3cc0c4d288f	Santo Domingo, Dominican Republic	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/santo-domingo-dominican-republic-250px.jpg	f	english	2016-08-25 15:13:07.283+08
71a632e7-1fc1-4a95-86fb-7994aae70134	Omaha, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/omaha-ne-united-states-250px.jpg	f	english	2016-08-25 15:13:07.284+08
05eecf2b-2050-4bef-9983-73c53d0273f9	New Taipei City, Taiwan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/new-taipei-city-taiwan-250px.jpg	f	english	2016-08-25 15:13:07.285+08
2428e4aa-7e9c-4801-9248-12db0f8bb1fb	Kaohsiung, Taiwan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kaohsiung-taiwan-250px.jpg	f	english	2016-08-25 15:13:07.286+08
2495259d-49a6-44ff-8c1b-08fd2dacc3d2	Fukuoka, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/fukuoka-japan-250px.jpg	f	english	2016-08-25 15:13:07.287+08
8ed93116-15d0-467e-a90a-ccacf82be439	Sliema, Malta	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/sliema-malta-250px.jpg	f	english	2016-08-25 15:13:07.288+08
20bdbbac-7af4-448e-8eba-b1fb67f543c2	Boise, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/boise-id-united-states-250px.jpg	f	english	2016-08-25 15:13:07.289+08
48b31717-00a7-4403-a9ae-8e5e09334d48	Regina, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/regina-canada-250px.jpg	f	english	2016-08-25 15:13:07.29+08
29a75ba6-937e-4590-a721-fb7ae40ef1ba	Puerto Vallarta, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/puerto-vallarta-mexico-250px.jpg	f	english	2016-08-25 15:13:07.291+08
ed043ea9-db95-43e6-957d-7a293995eb21	Coimbra, Portugal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/coimbra-portugal-250px.jpg	f	english	2016-08-25 15:13:07.292+08
5a949ab3-0d18-4091-83c4-78ebba57bd06	Zagreb, Croatia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/zagreb-croatia-250px.jpg	f	english	2016-08-25 15:13:07.293+08
598cd3f0-dc85-4079-9ad9-70b46fb4a54f	Fargo, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/fargo-nd-united-states-250px.jpg	f	english	2016-08-25 15:13:07.294+08
98897451-0ab2-4b15-add4-04b0a1edc7c3	Chico, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chico-ca-united-states-250px.jpg	f	english	2016-08-25 15:13:07.295+08
1e06a52d-4f62-4ece-acd7-c39983425663	Nantes, France	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nantes-france-250px.jpg	f	english	2016-08-25 15:13:07.296+08
e2f9f588-3c72-44f9-adcf-a519884d542e	Cork, Ireland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cork-ireland-250px.jpg	f	english	2016-08-25 15:13:07.297+08
43650a9b-b048-4ced-8dfe-78cc7593dff4	Barrie, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/barrie-canada-250px.jpg	f	english	2016-08-25 15:13:07.298+08
f05ce68a-7e02-4170-9643-47350a552a3b	Saskatoon, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/saskatoon-canada-250px.jpg	f	english	2016-08-25 15:13:07.299+08
ae16deab-cf86-4fd6-a82d-9559950fe640	Osijek, Croatia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/osijek-croatia-250px.jpg	f	english	2016-08-25 15:13:07.3+08
8aebaa16-ec24-4350-913d-0f2b439281c0	Vilnius, Lithuania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/vilnius-lithuania-250px.jpg	f	english	2016-08-25 15:13:07.301+08
84d7b704-e0de-4755-8e2c-d3a6cfc5d482	Malmo, Sweden	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/malmo-sweden-250px.jpg	f	english	2016-08-25 15:13:07.302+08
4fb9cb85-5a78-4a64-94d1-46de7c74c70c	Turku, Finland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/turku-finland-250px.jpg	f	english	2016-08-25 15:13:07.303+08
96527533-fd6c-4678-acd6-3ebe7421f669	A Coruna, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/a-coruna-spain-250px.jpg	f	english	2016-08-25 15:13:07.304+08
0f9af025-7ba0-4bb3-854f-b7a52b21f1d2	Bangalore, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bangalore-india-250px.jpg	f	english	2016-08-25 15:13:07.305+08
ccbd2720-be4a-42b9-bf9f-73b70e3cac22	Gainesville, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/gainesville-fl-united-states-250px.jpg	f	english	2016-08-25 15:13:07.306+08
d29aada7-d2c6-4359-89a7-fec8f4ebc4b3	Kitakyushu, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kitakyushu-japan-250px.jpg	f	english	2016-08-25 15:13:07.307+08
2971264b-dc7a-4be5-b87d-8c8ec22f87cc	Belo Horizonte, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/belo-horizonte-brazil-250px.jpg	f	english	2016-08-25 15:13:07.308+08
a1536724-e4ab-4d18-9b0e-4e5d31cc8aa2	Winnipeg, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/winnipeg-canada-250px.jpg	f	english	2016-08-25 15:13:07.309+08
c45334bc-971f-46e5-88da-a8f739aad305	Brampton, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/brampton-canada-250px.jpg	f	english	2016-08-25 15:13:07.311+08
da37b2c8-c655-46ac-980d-c53ce39e23af	Reno, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/reno-nv-united-states-250px.jpg	f	english	2016-08-25 15:13:07.312+08
50b9b251-1445-42c6-8ab0-44129495ba96	Birmingham, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/birmingham-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.313+08
ae7e8906-7561-43b1-a8bd-b1b325cc2465	Queretaro, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/queretaro-mexico-250px.jpg	f	english	2016-08-25 15:13:07.314+08
6d273982-36d3-45e3-91f7-bd5655901ca9	Malaga, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/malaga-spain-250px.jpg	f	english	2016-08-25 15:13:07.315+08
fe35e574-6b07-4779-ae7a-0321fe03d7de	Dublin, Ireland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dublin-ireland-250px.jpg	f	english	2016-08-25 15:13:07.316+08
1de2b016-d62f-48f4-acbf-e6270f7a99ef	Fresno, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/fresno-ca-united-states-250px.jpg	f	english	2016-08-25 15:13:07.317+08
d2f79a11-1128-4670-a41e-d45cf01bf11a	Hobart, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hobart-australia-250px.jpg	f	english	2016-08-25 15:13:07.318+08
ef86de2b-77f9-4cbe-b23c-3224dea34c35	San Juan, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/san-juan-pr-united-states-250px.jpg	f	english	2016-08-25 15:13:07.32+08
f63523ed-2719-4ec7-80a3-88b6fb483b1f	Taichung, Taiwan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/taichung-taiwan-250px.jpg	f	english	2016-08-25 15:13:07.321+08
79c2966f-7249-454b-94fc-590b42b364d4	Chatham, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chatham-canada-250px.jpg	f	english	2016-08-25 15:13:07.322+08
c7bd13f5-967b-4d5f-a596-2947476943b5	Gothenburg, Sweden	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/gothenburg-sweden-250px.jpg	f	english	2016-08-25 15:13:07.323+08
3e4f179b-1db6-4fe8-b4a8-362af2ab573c	Campinas, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/campinas-brazil-250px.jpg	f	english	2016-08-25 15:13:07.324+08
5eeed36e-309f-4000-908c-1211b86b2948	Dayton, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dayton-oh-united-states-250px.jpg	f	english	2016-08-25 15:13:07.325+08
45c56880-66b1-4869-9f66-9d06bfb310a6	Toronto, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/toronto-canada-250px.jpg	f	english	2016-08-25 15:13:07.326+08
de39eb98-d655-4c03-9825-7a6776223a15	Jakarta, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jakarta-indonesia-250px.jpg	f	english	2016-08-25 15:13:07.327+08
65a2f97a-48e1-4d35-bc90-3a188143705a	Kaunas, Lithuania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kaunas-lithuania-250px.jpg	f	english	2016-08-25 15:13:07.328+08
7e01fb95-ab4f-4c79-9ceb-fa18e960b617	Alicante, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/alicante-spain-250px.jpg	f	english	2016-08-25 15:13:07.329+08
2e1fb3bc-a90d-4126-a076-50d7e485f700	Milan, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/milan-italy-250px.jpg	f	english	2016-08-25 15:13:07.33+08
bbd1862e-2fa8-4a34-892f-d221266349ca	Constanta, Romania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/constanta-romania-250px.jpg	f	english	2016-08-25 15:13:07.331+08
1cfb372c-23fd-4c10-a7e9-5cbb6ba0e4cd	Gdansk, Poland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/gdansk-poland-250px.jpg	f	english	2016-08-25 15:13:07.332+08
8164aa63-2f29-4343-90b7-a8c71493a46f	Avellino, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/avellino-italy-250px.jpg	f	english	2016-08-25 15:13:07.333+08
900b08d8-90e5-43c7-8782-e5fab3601bb2	Istanbul, Turkey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/istanbul-turkey-250px.jpg	f	english	2016-08-25 15:13:07.334+08
723cdb55-6d77-4c67-982c-e1d4c86ec9ef	Edmonton, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/edmonton-canada-250px.jpg	f	english	2016-08-25 15:13:07.335+08
610d561a-d3b5-4a90-a34c-b39bc50c9cb5	Tbilisi, Georgia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tbilisi-georgia-250px.jpg	f	english	2016-08-25 15:13:07.336+08
b8c66830-f9b5-434c-a03e-c95a98cd8865	Bloomington, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bloomington-in-united-states-250px.jpg	f	english	2016-08-25 15:13:07.337+08
6b9bdcfb-933f-4d05-872b-202db778f9bc	Tampere, Finland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tampere-finland-250px.jpg	f	english	2016-08-25 15:13:07.338+08
698a23a8-d171-46c8-8825-b0cf345ef8d2	Monterrey, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/monterrey-mexico-250px.jpg	f	english	2016-08-25 15:13:07.339+08
dfe714b4-8ce9-4764-b93f-d7a1d1a30c3e	Melbourne, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/melbourne-australia-250px.jpg	f	english	2016-08-25 15:13:07.34+08
80a1fc65-1862-45db-b553-16d672b1cf4e	Gwangju, South Korea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/gwangju-south-korea-250px.jpg	f	english	2016-08-25 15:13:07.341+08
6d6acba7-f5ac-44a3-9ddb-b9a99f95ab16	Iasi, Romania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/iasi-romania-250px.jpg	f	english	2016-08-25 15:13:07.342+08
c24cf405-a408-4d02-a656-f283d5218ac4	Seville, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/seville-spain-250px.jpg	f	english	2016-08-25 15:13:07.343+08
fa03c135-070c-499d-93f8-c5f38501b40e	Abbotsford, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/abbotsford-canada-250px.jpg	f	english	2016-08-25 15:13:07.343+08
fc91fcb1-86e1-49be-b139-88a4183fc175	Hoi An, Vietnam	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hoi-an-vietnam-250px.jpg	f	english	2016-08-25 15:13:07.344+08
7e625b79-a80e-49b1-8d68-4993925f800c	Como, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/como-italy-250px.jpg	f	english	2016-08-25 15:13:07.345+08
eda1e52a-3093-461a-9b50-d9b8465386c6	Panama City, Panama	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/panama-city-panama-250px.jpg	f	english	2016-08-25 15:13:07.346+08
c72d28b7-c9ed-4214-a78a-2fc759d522e4	Sarajevo, Bosnia-Herzegovina	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/sarajevo-bosnia-herzegovina-250px.jpg	f	english	2016-08-25 15:13:07.347+08
76498de6-dd14-464d-93ca-134acd5402c4	Bournemouth, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bournemouth-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.348+08
4409c05c-5542-468c-b905-e0dedf8d1f10	Hangzhou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hangzhou-china-250px.jpg	f	english	2016-08-25 15:13:07.348+08
db35be5d-300e-466e-bb3a-8363a1660cf1	Brno, Czech Republic	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/brno-czech-republic-250px.jpg	f	english	2016-08-25 15:13:07.349+08
f9e59ce9-3a28-486a-9979-c06cd252d4e5	Amman, Jordan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/amman-jordan-250px.jpg	f	english	2016-08-25 15:13:07.35+08
1a69dacd-6055-496f-9de7-9598d3408186	Moscow, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/moscow-russia-250px.jpg	f	english	2016-08-25 15:13:07.351+08
3144dc93-73b9-4f8a-ad8a-00577ec16a33	Sapporo, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/sapporo-japan-250px.jpg	f	english	2016-08-25 15:13:07.352+08
788c21bf-5b00-44d7-8edc-11d9fc54e081	Vancouver, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/vancouver-canada-250px.jpg	f	english	2016-08-25 15:13:07.352+08
a89d37e6-699d-488b-9df8-ba41d953eec1	Ploiesti, Romania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ploiesti-romania-250px.jpg	f	english	2016-08-25 15:13:07.353+08
a9bcea60-cbae-4fd6-a9d6-a97480207d71	Puerto Viejo, Costa Rica	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/puerto-viejo-costa-rica-250px.jpg	f	english	2016-08-25 15:13:07.354+08
0a641138-b871-4464-8314-181af0e73aa4	St.Catharines, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/stcatharines-canada-250px.jpg	f	english	2016-08-25 15:13:07.354+08
2ab03ef7-fcae-4d53-9757-d509a15fdde3	Turin, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/turin-italy-250px.jpg	f	english	2016-08-25 15:13:07.355+08
a6617399-8df2-4946-a95b-f1dcd28c7c91	Bar, Montenegro	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bar-montenegro-250px.jpg	f	english	2016-08-25 15:13:07.356+08
07ad5141-8735-468f-943b-a0c1f7e6b1c3	Lethbridge, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lethbridge-canada-250px.jpg	f	english	2016-08-25 15:13:07.357+08
b10fd550-74d9-45d0-b4d2-7d068f1d7dee	Leeds, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/leeds-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.357+08
3e8a98aa-c111-4b9f-8a02-64e26a851ace	Mexico City, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/mexico-city-mexico-250px.jpg	f	english	2016-08-25 15:13:07.358+08
dedcac30-3fb8-4048-b6ea-f91a737d3bef	Rijeka, Croatia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/rijeka-croatia-250px.jpg	f	english	2016-08-25 15:13:07.359+08
376b9715-0486-420d-ba28-ab79da7053b4	Kelowna, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kelowna-canada-250px.jpg	f	english	2016-08-25 15:13:07.36+08
0373dcdb-360d-4700-b51e-b516c68ba3e0	Plovdiv, Bulgaria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/plovdiv-bulgaria-250px.jpg	f	english	2016-08-25 15:13:07.361+08
77873077-2655-4706-9374-25808b1d46d0	Florence, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/florence-italy-250px.jpg	f	english	2016-08-25 15:13:07.361+08
43e64890-0c7a-4610-97da-9ee8b80cf8c7	Bucharest, Romania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bucharest-romania-250px.jpg	f	english	2016-08-25 15:13:07.362+08
fa782265-a0e8-420b-930a-6efa77eb01e3	Belfast, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/belfast-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.363+08
9d08beca-4af9-4b73-a830-25c4e59c0122	Virginia Beach, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/virginia-beach-va-united-states-250px.jpg	f	english	2016-08-25 15:13:07.363+08
3c1d2a28-0583-4167-b3f3-d9de94d21c34	Tirana, Albania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tirana-albania-250px.jpg	f	english	2016-08-25 15:13:07.364+08
0a573a0f-7ce9-427d-8cbc-25dec9c81eae	Santiago, Chile	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/santiago-chile-250px.jpg	f	english	2016-08-25 15:13:07.365+08
0bea9260-5a9b-4454-8c1e-d927ae89e2b4	Rethymno, Greece	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/rethymno-greece-250px.jpg	f	english	2016-08-25 15:13:07.366+08
4dc74120-d4ea-424f-9562-ee0b1e10f925	Copenhagen, Denmark	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/copenhagen-denmark-250px.jpg	f	english	2016-08-25 15:13:07.366+08
32b78044-cf9d-4fd2-8c8e-1d60dc17c565	Hiroshima, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hiroshima-japan-250px.jpg	f	english	2016-08-25 15:13:07.368+08
ccda59dc-2dcc-4225-aee7-e66601c91fb2	Treviso, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/treviso-italy-250px.jpg	f	english	2016-08-25 15:13:07.369+08
2e2e552e-c71e-4093-abf1-c75f67f4a230	Kharkiv, Ukraine	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kharkiv-ukraine-250px.jpg	f	english	2016-08-25 15:13:07.369+08
094293e2-6969-4938-87ba-7ea7c13c5433	Granada, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/granada-spain-250px.jpg	f	english	2016-08-25 15:13:07.37+08
c47c310a-9f32-4074-a32b-b52b9cda5398	Fredericton, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/fredericton-canada-250px.jpg	f	english	2016-08-25 15:13:07.371+08
57dbe119-951c-4464-8718-982215b0f92b	Hyderabad, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hyderabad-india-250px.jpg	f	english	2016-08-25 15:13:07.372+08
2ef844f8-be04-4825-a863-993435bebefe	Dresden, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dresden-germany-250px.jpg	f	english	2016-08-25 15:13:07.373+08
fc63f028-fbc9-4879-8d2b-020bd54cec83	Oakland, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/oakland-ca-united-states-250px.jpg	f	english	2016-08-25 15:13:07.374+08
b8745574-f4b4-4c9d-bb5b-3cfb8a8d5492	Los Angeles, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/los-angeles-ca-united-states-250px.jpg	f	english	2016-08-25 15:13:07.375+08
1b5b36a8-9e19-48fb-9ca6-7bc4c34d08a9	Oxford, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/oxford-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.376+08
ba0833dd-bfcb-479b-916c-6c5bbeb09aaf	Nijmegen, Netherlands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nijmegen-netherlands-250px.jpg	f	english	2016-08-25 15:13:07.376+08
50d9a05e-b9cc-4817-9033-d22a7a990940	London, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/london-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.377+08
8a58d3f5-3ff1-4f5c-a6d8-eacd9a7a4cd8	Kingston, Jamaica	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kingston-jamaica-250px.jpg	f	english	2016-08-25 15:13:07.378+08
339725dd-46d3-497f-898e-b7dde783ec51	Poznan, Poland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/poznan-poland-250px.jpg	f	english	2016-08-25 15:13:07.379+08
7561a895-ac63-47e3-b9e9-bcbac90fb4c5	Nanaimo, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nanaimo-canada-250px.jpg	f	english	2016-08-25 15:13:07.38+08
87fb179b-577a-4b66-8142-0bfa602ff11c	Chachapoyas, Peru	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chachapoyas-peru-250px.jpg	f	english	2016-08-25 15:13:07.38+08
b68161c7-3ce6-4da2-b64e-d498cd575091	New York City, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/new-york-city-ny-united-states-250px.jpg	f	english	2016-08-25 15:13:07.381+08
8d7abde7-c053-4fbc-b08f-517fadf375b0	Craiova, Romania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/craiova-romania-250px.jpg	f	english	2016-08-25 15:13:07.382+08
73c49800-901e-472b-82c3-7b17c5a9d89c	Limassol, Cyprus	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/limassol-cyprus-250px.jpg	f	english	2016-08-25 15:13:07.383+08
ebdb044a-84d7-4bff-8307-d04c8202f1c0	Norwich, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/norwich-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.383+08
065bb483-1fa3-4787-8bfd-613c1d72fa38	Split, Croatia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/split-croatia-250px.jpg	f	english	2016-08-25 15:13:07.384+08
c1dc0ae2-72b3-474a-8257-06469a77e2d8	Aalesund, Norway	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/aalesund-norway-250px.jpg	f	english	2016-08-25 15:13:07.385+08
42d3ddf8-1da8-41e6-be78-b7193e1ce7d7	Newark, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/newark-nj-united-states-250px.jpg	f	english	2016-08-25 15:13:07.386+08
73174ada-59c5-4cfc-9628-1ab3c82b0ad7	Obninsk, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/obninsk-russia-250px.jpg	f	english	2016-08-25 15:13:07.386+08
bf65406b-21d9-4512-bd87-f96a79116ce8	Lodz, Poland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lodz-poland-250px.jpg	f	english	2016-08-25 15:13:07.387+08
c5407921-f3e9-489f-8401-df05fececd8d	Aachen, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/aachen-germany-250px.jpg	f	english	2016-08-25 15:13:07.388+08
1684571d-3b8e-4f97-a608-3a41ca2fdafe	Baku, Azerbaijan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/baku-azerbaijan-250px.jpg	f	english	2016-08-25 15:13:07.389+08
7bd3331f-e917-4385-bd17-7ff6e0b3bc32	Moncton, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/moncton-canada-250px.jpg	f	english	2016-08-25 15:13:07.389+08
39d7787d-92cb-4856-9a75-9ebc0dcff364	Saratov, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/saratov-russia-250px.jpg	f	english	2016-08-25 15:13:07.39+08
26891192-6b7f-4f44-8209-a91df91d2128	Hannover, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hannover-germany-250px.jpg	f	english	2016-08-25 15:13:07.391+08
42dbcb02-4bb3-45c8-9a17-2795a0ef5f72	San Miguel de Allende, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/san-miguel-de-allende-mexico-250px.jpg	f	english	2016-08-25 15:13:07.392+08
b12ee9a8-49dc-48cf-8c8f-eb94a30cc687	Mar del Plata, Argentina	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/mar-del-plata-argentina-250px.jpg	f	english	2016-08-25 15:13:07.392+08
410ef6cd-e017-42a6-a653-10f7ef9a2b31	Singapore, Singapore	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/singapore-singapore-250px.jpg	f	english	2016-08-25 15:13:07.393+08
0ecae502-a2fd-42b6-a15e-cc45edf189fc	Brasilia, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/brasilia-brazil-250px.jpg	f	english	2016-08-25 15:13:07.394+08
a462a14a-cec6-461c-a811-5685e19331ce	Genoa, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/genoa-italy-250px.jpg	f	english	2016-08-25 15:13:07.395+08
f1b480ac-cfad-4837-9a82-ca78f527fe15	Helsinki, Finland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/helsinki-finland-250px.jpg	f	english	2016-08-25 15:13:07.396+08
30f5116b-b8c1-49f6-a621-bab48c60062d	Bandung, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bandung-indonesia-250px.jpg	f	english	2016-08-25 15:13:07.396+08
74b6899d-3564-44e5-90ed-4ff5722a6c8f	Macau, Macau	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/macau-macau-250px.jpg	f	english	2016-08-25 15:13:07.397+08
1dbb7dd2-620e-42bf-9a68-9cfcff4484a7	Yekaterinburg, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/yekaterinburg-russia-250px.jpg	f	english	2016-08-25 15:13:07.398+08
e9c64fc8-e7a7-4d7b-8c03-1b77cbd6c4c3	Cambridge, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cambridge-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.399+08
ffbf4613-f453-4b59-b8ea-3f886da5598d	Weifang, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/weifang-china-250px.jpg	f	english	2016-08-25 15:13:07.399+08
dba7cc72-5fbd-445a-904a-f81d958a901e	Gold Coast, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/gold-coast-australia-250px.jpg	f	english	2016-08-25 15:13:07.4+08
8c5f2d32-711d-4323-964b-2e91fc7b63c4	Sendai, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/sendai-japan-250px.jpg	f	english	2016-08-25 15:13:07.401+08
d0bf4aec-dac1-4df4-819b-5a6142cc692e	Galway, Ireland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/galway-ireland-250px.jpg	f	english	2016-08-25 15:13:07.402+08
0e175ca2-e2f3-4027-bf71-1fbd137f3a84	Lima, Peru	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lima-peru-250px.jpg	f	english	2016-08-25 15:13:07.403+08
fe1a46c6-8c43-4fd8-9852-cc0daa207369	Cardiff, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cardiff-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.404+08
e92c6624-4db5-4c95-a401-45b795dfae3c	Tel Aviv, Israel	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tel-aviv-israel-250px.jpg	f	english	2016-08-25 15:13:07.405+08
8dc658c2-4dbd-4eb9-b9b7-9cf801a42038	Washington, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/washington-dc-united-states-250px.jpg	f	english	2016-08-25 15:13:07.406+08
bd00c442-d0c9-4674-8b6a-85a495806900	Barcelona, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/barcelona-spain-250px.jpg	f	english	2016-08-25 15:13:07.407+08
16635467-128f-47d7-a6bd-5ca46a73992b	Jarabacoa, Dominican Republic	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jarabacoa-dominican-republic-250px.jpg	f	english	2016-08-25 15:13:07.408+08
46c722b2-6a00-4a82-b66d-028bb95ff83e	Nanyang, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nanyang-china-250px.jpg	f	english	2016-08-25 15:13:07.409+08
82a6324f-7869-4df3-893c-e2102111de5c	San Francisco, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/san-francisco-ca-united-states-250px.jpg	f	english	2016-08-25 15:13:07.41+08
9d91297f-83f5-4325-ab02-cd1660587c80	Krasnodar, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/krasnodar-russia-250px.jpg	f	english	2016-08-25 15:13:07.411+08
553d26e0-e740-4f5f-a150-aec1d9f66371	La Plata, Argentina	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/la-plata-argentina-250px.jpg	f	english	2016-08-25 15:13:07.412+08
2038c836-8a92-4f75-beba-cd0ba04f739d	Santa Monica, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/santa-monica-ca-united-states-250px.jpg	f	english	2016-08-25 15:13:07.413+08
7dfadf77-651e-4ce1-a6bd-1134d9de2610	Oaxaca, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/oaxaca-mexico-250px.jpg	f	english	2016-08-25 15:13:07.414+08
db618c07-ce19-4f33-bfb7-f8a0722b8d29	Colombo, Sri Lanka	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/colombo-sri-lanka-250px.jpg	f	english	2016-08-25 15:13:07.415+08
9e5fc0bc-0b12-4164-aef6-38bd06137813	Grenoble, France	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/grenoble-france-250px.jpg	f	english	2016-08-25 15:13:07.416+08
8d6dfa95-5f17-4ae9-b7d6-e0d0fd4c2ac0	Johor Bahru, Malaysia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/johor-bahru-malaysia-250px.jpg	f	english	2016-08-25 15:13:07.417+08
34f99ea0-1e42-4834-9a5b-210016fea3e7	Kuala Lumpur, Malaysia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kuala-lumpur-malaysia-250px.jpg	f	english	2016-08-25 15:13:07.418+08
c4756705-dbaa-4b73-8887-4eff157425b3	Curitiba, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/curitiba-brazil-250px.jpg	f	english	2016-08-25 15:13:07.419+08
fbba36dd-5d6b-40d9-b8ff-6e14f9cbd112	Ko Pha Ngan, Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ko-pha-ngan-thailand-250px.jpg	f	english	2016-08-25 15:13:07.42+08
2e7f9b77-7d66-402a-a7cc-07239ba954db	Burgas, Bulgaria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/burgas-bulgaria-250px.jpg	f	english	2016-08-25 15:13:07.421+08
5c2cf3db-1afd-48bb-9877-2b27328249b7	Saint Petersburg, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/saint-petersburg-russia-250px.jpg	f	english	2016-08-25 15:13:07.422+08
e4adc230-522c-43d7-a485-940a3b05853a	Bologna, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bologna-italy-250px.jpg	f	english	2016-08-25 15:13:07.423+08
7673e658-03f6-4eb8-8c4e-c586a0f94107	Bursa, Turkey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bursa-turkey-250px.jpg	f	english	2016-08-25 15:13:07.424+08
b82d042e-963f-4d47-9fba-20e5bdfa9d19	Asuncion, Paraguay	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/asuncion-paraguay-250px.jpg	f	english	2016-08-25 15:13:07.425+08
e324b563-fd6a-4dc8-9dd0-9a8875f3353c	Chisinau, Moldova	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chisinau-moldova-250px.jpg	f	english	2016-08-25 15:13:07.426+08
b95e4a6b-9cb2-4afb-88c4-254826ffc3bb	Tianjin, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tianjin-china-250px.jpg	f	english	2016-08-25 15:13:07.427+08
402ea30e-5b27-4e88-9610-0a7fcaa21a48	Katowice, Poland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/katowice-poland-250px.jpg	f	english	2016-08-25 15:13:07.428+08
0a26ae46-435c-4549-923d-f278432b6b1d	Goiania, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/goiania-brazil-250px.jpg	f	english	2016-08-25 15:13:07.429+08
d884d14d-f62d-4f72-8c39-2de2979453b0	Salzburg, Austria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/salzburg-austria-250px.jpg	f	english	2016-08-25 15:13:07.43+08
e515792c-d899-48c6-a6eb-b8fe0702245d	Ramallah, Palestine	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ramallah-palestine-250px.jpg	f	english	2016-08-25 15:13:07.431+08
f68dd264-1bcd-4851-924e-41816c0846fe	Tromso, Norway	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tromso-norway-250px.jpg	f	english	2016-08-25 15:13:07.432+08
8c33359b-bffd-4098-b557-423047917951	Sydney, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/sydney-australia-250px.jpg	f	english	2016-08-25 15:13:07.433+08
ec29ea2d-9e65-41b7-b33e-2410d85db44c	Southampton, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/southampton-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.434+08
e495d644-3017-4411-a5a3-c35ba04b9e33	Zurich, Switzerland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/zurich-switzerland-250px.jpg	f	english	2016-08-25 15:13:07.435+08
504c7e72-f967-4190-b8b7-18889fe6009c	Managua, Nicaragua	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/managua-nicaragua-250px.jpg	f	english	2016-08-25 15:13:07.436+08
b2a4614d-9f78-4bf0-a1c1-3a42400b55bc	Pattaya, Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/pattaya-thailand-250px.jpg	f	english	2016-08-25 15:13:07.438+08
231483ac-2977-4fb5-b50f-84144ae52335	Podgorica, Montenegro	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/podgorica-montenegro-250px.jpg	f	english	2016-08-25 15:13:07.439+08
a632c66e-d417-465c-8567-f0219e659637	Naha, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/naha-japan-250px.jpg	f	english	2016-08-25 15:13:07.44+08
44597081-1004-4944-a3b5-1709cfd20b3f	Zhoukou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/zhoukou-china-250px.jpg	f	english	2016-08-25 15:13:07.441+08
e420117b-981b-4a2a-8130-c13256b6bc96	Gibraltar, Gibraltar	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/gibraltar-gibraltar-250px.jpg	f	english	2016-08-25 15:13:07.441+08
235b6622-5ad2-4b72-a89a-24ffef19dadd	Hilo, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hilo-hawaii-united-states-250px.jpg	f	english	2016-08-25 15:13:07.442+08
51ed4be3-d709-4fc6-b475-54c8a665572f	Izhevsk, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/izhevsk-russia-250px.jpg	f	english	2016-08-25 15:13:07.443+08
45b4d4ef-77c7-4a16-b9b0-542fe42e921f	Dalian, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dalian-china-250px.jpg	f	english	2016-08-25 15:13:07.444+08
77d36c02-0664-4cf1-8fb2-13a4e4201bad	Saint Louis, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/saint-louis-mo-united-states-250px.jpg	f	english	2016-08-25 15:13:07.445+08
0111c654-372b-441b-a31b-28e88cc1c2c1	Canberra, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/canberra-australia-250px.jpg	f	english	2016-08-25 15:13:07.447+08
a1f63a2c-42ac-4c6e-9799-74ab497561b7	Cartagena, Colombia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cartagena-colombia-250px.jpg	f	english	2016-08-25 15:13:07.448+08
beedd6aa-65ef-444f-8f0c-eb96b3c95dbb	Davao, Philippines	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/davao-philippines-250px.jpg	f	english	2016-08-25 15:13:07.449+08
335d15bb-0d11-4673-8485-745728dfcaf1	Nagoya, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nagoya-japan-250px.jpg	f	english	2016-08-25 15:13:07.45+08
03b9cac8-bf49-4112-a2d9-837ac9f5b0b6	Dakar, Senegal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dakar-senegal-250px.jpg	f	english	2016-08-25 15:13:07.451+08
751ec973-b3b4-4486-8e17-d3c90ec95549	Paris, France	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/paris-france-250px.jpg	f	english	2016-08-25 15:13:07.452+08
96c3feb8-e4a9-4eb5-ab26-6925cd9214f1	Noida, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/noida-india-250px.jpg	f	english	2016-08-25 15:13:07.452+08
da7480f8-a7b7-416f-8261-33272832916c	Beijing, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/beijing-china-250px.jpg	f	english	2016-08-25 15:13:07.453+08
839ba9f2-eaa3-4dc6-8097-711ff10ef16d	Northampton, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/northampton-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.454+08
72d41e63-10e8-4d7e-a249-fd35396df067	Trieste, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/trieste-italy-250px.jpg	f	english	2016-08-25 15:13:07.455+08
5c83c149-964c-409a-9f76-86129c4f3247	Nicosia, Cyprus	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nicosia-cyprus-250px.jpg	f	english	2016-08-25 15:13:07.456+08
84337c61-86b2-4f33-870f-f1e3de883ebe	Dunedin, New Zealand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dunedin-new-zealand-250px.jpg	f	english	2016-08-25 15:13:07.457+08
76963a55-d273-4def-b924-477f288cec82	Anyang, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/anyang-china-250px.jpg	f	english	2016-08-25 15:13:07.458+08
32063c50-941f-4811-ac27-dda70b116351	Amsterdam, Netherlands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/amsterdam-netherlands-250px.jpg	f	english	2016-08-25 15:13:07.459+08
8e3ad621-1aec-429d-bb05-877de7ba1358	Sharjah, United Arab Emirates	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/sharjah-united-arab-emirates-250px.jpg	f	english	2016-08-25 15:13:07.459+08
1d730036-4027-4b3d-a2e1-e124e1271d19	Luxembourg, Luxembourg	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/luxembourg-luxembourg-250px.jpg	f	english	2016-08-25 15:13:07.46+08
6e69b168-574b-48a9-9865-e4bb7f76f320	Palawan, Philippines	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/palawan-philippines-250px.jpg	f	english	2016-08-25 15:13:07.461+08
661dd04f-17e2-4337-8632-a03ee127daed	Izmir, Turkey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/izmir-turkey-250px.jpg	f	english	2016-08-25 15:13:07.462+08
0e648118-577d-40cf-8ff7-1bfe9b4d8adc	Anchorage, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/anchorage-ak-united-states-250px.jpg	f	english	2016-08-25 15:13:07.463+08
db5993c4-9521-479c-8556-3a5a07c0f4d6	Jyvaskyla, Finland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jyvaskyla-finland-250px.jpg	f	english	2016-08-25 15:13:07.464+08
5fef8e00-b96f-423d-9eae-b868f19e2f1c	Verona, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/verona-italy-250px.jpg	f	english	2016-08-25 15:13:07.465+08
a7e3278f-b538-46d2-b07c-adfadf319315	Huntsville, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/huntsville-al-united-states-250px.jpg	f	english	2016-08-25 15:13:07.466+08
aadda775-abcd-4843-9a9b-5696bca52e67	Ivano-Frankivsk, Ukraine	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ivano-frankivsk-ukraine-250px.jpg	f	english	2016-08-25 15:13:07.468+08
a0469cce-1d66-4b82-9f22-c7186b437fb7	Kazan, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kazan-russia-250px.jpg	f	english	2016-08-25 15:13:07.469+08
d49e8f6f-7753-4ee9-92c0-9267ebdcea90	Havana, Cuba	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/havana-cuba-250px.jpg	f	english	2016-08-25 15:13:07.47+08
78affa9b-7d5a-4d63-a7a3-bfc9298d1c29	Merida, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/merida-mexico-250px.jpg	f	english	2016-08-25 15:13:07.471+08
d701b8f3-1006-4f86-81c0-ce310f0d2be6	Taghazout, Morocco	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/taghazout-morocco-250px.jpg	f	english	2016-08-25 15:13:07.472+08
ca97481e-f244-4746-a619-2ffd241d81d4	Boston, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/boston-ma-united-states-250px.jpg	f	english	2016-08-25 15:13:07.472+08
45b81de0-9533-4187-afcf-f1798e521104	Fortaleza, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/fortaleza-brazil-250px.jpg	f	english	2016-08-25 15:13:07.473+08
3960dec0-9dcc-4247-85a7-6167ad7d38d0	Dorobo, Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dorobo-japan-250px.jpg	f	english	2016-08-25 15:13:07.474+08
5f2537a6-541f-4a20-8bf5-f190218f3545	Aberdeen, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/aberdeen-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.475+08
4155cfa3-1e75-43ee-bd10-620eee953ffc	Lugano, Switzerland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lugano-switzerland-250px.jpg	f	english	2016-08-25 15:13:07.476+08
4796c4f7-ca01-43f5-a8c5-3c38df85697d	Florianopolis, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/florianopolis-brazil-250px.jpg	f	english	2016-08-25 15:13:07.477+08
2a77be8a-a932-4e23-aca2-467a1a88cc29	Chengdu, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chengdu-china-250px.jpg	f	english	2016-08-25 15:13:07.478+08
7a65d5f2-b1de-4529-8a61-c011f7058239	Casablanca, Morocco	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/casablanca-morocco-250px.jpg	f	english	2016-08-25 15:13:07.479+08
996ac393-56a6-4018-991c-c6b2c3b012ce	Rome, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/rome-italy-250px.jpg	f	english	2016-08-25 15:13:07.48+08
4aa36677-b65b-4def-9f65-371b22521724	Bhubaneswar, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bhubaneswar-india-250px.jpg	f	english	2016-08-25 15:13:07.481+08
e8fcadeb-3129-444c-9915-a4ac4ecb74b5	Chelyabinsk, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chelyabinsk-russia-250px.jpg	f	english	2016-08-25 15:13:07.482+08
86734e97-fdbb-459d-9cd8-2d3c7fcbcfd1	Tomsk, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tomsk-russia-250px.jpg	f	english	2016-08-25 15:13:07.483+08
84633e28-d0db-4ba1-8237-048c37b6dd1d	Grodno, Belarus	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/grodno-belarus-250px.jpg	f	english	2016-08-25 15:13:07.484+08
98b82cdb-3b80-4fed-b0d9-c4ca219f3101	Almaty, Kazakhstan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/almaty-kazakhstan-250px.jpg	f	english	2016-08-25 15:13:07.485+08
53fb233d-3767-4c35-9806-c0b33a70b52b	Modena, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/modena-italy-250px.jpg	f	english	2016-08-25 15:13:07.486+08
da31331c-198f-4508-99f1-a7370e794431	Dongguan, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dongguan-china-250px.jpg	f	english	2016-08-25 15:13:07.487+08
45f16783-88b8-4340-9233-3556a7aef790	Detroit, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/detroit-mi-united-states-250px.jpg	f	english	2016-08-25 15:13:07.488+08
1e8b13e4-c84e-4a42-992c-d409c10d6ad0	Graz, Austria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/graz-austria-250px.jpg	f	english	2016-08-25 15:13:07.489+08
6313804a-a69e-42b5-b404-f74572575a29	Budva, Montenegro	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/budva-montenegro-250px.jpg	f	english	2016-08-25 15:13:07.49+08
839bd7fd-78b8-4f0b-a3bd-70c5c229f3ce	Krivoy-Rog, Ukraine	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/krivoy-rog-ukraine-250px.jpg	f	english	2016-08-25 15:13:07.491+08
1b23be6d-4465-4fe1-9dd4-7281c00979e8	Malang, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/malang-east-java-indonesia-250px.jpg	f	english	2016-08-25 15:13:07.492+08
d2b534f5-0631-4ffb-b74c-126d8314426c	Cairo, Egypt	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cairo-egypt-250px.jpg	f	english	2016-08-25 15:13:07.493+08
7c63925f-c0f8-41f1-a964-d831a177865f	Chania, Greece	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chania-greece-250px.jpg	f	english	2016-08-25 15:13:07.493+08
949ca8aa-bbd4-4293-8f0d-9271356495d2	Medellín, Colombia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/medellin-colombia-250px.jpg	f	english	2016-08-25 15:13:07.494+08
11cef35e-8b0f-4e70-a092-5995762a3f06	Monaco, Monaco	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/monaco-monaco-250px.jpg	f	english	2016-08-25 15:13:07.495+08
3f14305c-5ea6-4a86-baae-6614b14beb80	Srinagar, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/srinagar-india-250px.jpg	f	english	2016-08-25 15:13:07.496+08
c05ce276-9f0b-4892-9012-93af8d888810	Kaliningrad, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kaliningrad-russia-250px.jpg	f	english	2016-08-25 15:13:07.497+08
4a0d82d2-5ee4-427d-927d-ca5bb69cc3d0	New Delhi, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/new-delhi-india-250px.jpg	f	english	2016-08-25 15:13:07.499+08
8b9b9c3d-2f4c-4a30-95e5-73fc48cbeeef	Porto Alegre, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/porto-alegre-brazil-250px.jpg	f	english	2016-08-25 15:13:07.5+08
f5b7a89f-1d88-4da0-b9b8-cb7253e7871d	Suzhou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/suzhou-china-250px.jpg	f	english	2016-08-25 15:13:07.501+08
8338aa75-b45a-4590-a40e-fd6734cc845b	Geneva, Switzerland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/geneva-switzerland-250px.jpg	f	english	2016-08-25 15:13:07.502+08
fe9ee3fe-324a-47a0-b40f-65d170b45152	Fort McMurray, Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/fort-mcmurray-canada-250px.jpg	f	english	2016-08-25 15:13:07.503+08
fb03e54b-f76d-424d-9815-317e242ae8f7	Thane, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/thane-india-250px.jpg	f	english	2016-08-25 15:13:07.504+08
a45ec0a2-02f6-4801-9cc8-5f8f679128d5	Da Nang, Vietnam	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/da-nang-vietnam-250px.jpg	f	english	2016-08-25 15:13:07.505+08
ea5901d4-0393-4281-90b7-d321faae63d9	Reykjavik, Iceland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/reykjavik-iceland-250px.jpg	f	english	2016-08-25 15:13:07.506+08
24886922-09f6-4f47-880e-f6128e91cad4	Krasnoyarsk, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/krasnoyarsk-russia-250px.jpg	f	english	2016-08-25 15:13:07.507+08
dc6ece69-c009-467e-a249-d2c98e0bb545	Ufa, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ufa-russia-250px.jpg	f	english	2016-08-25 15:13:07.509+08
7f74fba3-d1fa-468a-aa5a-a77fdb014fd2	Darwin, Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/darwin-australia-250px.jpg	f	english	2016-08-25 15:13:07.51+08
19a85d65-0e38-4f8f-b347-11a06391a9c1	Asheville, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/asheville-nc-united-states-250px.jpg	f	english	2016-08-25 15:13:07.511+08
06511de4-5c54-47b0-ae25-10275bec895d	Ulaanbaatar, Mongolia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ulaanbaatar-mongolia-250px.jpg	f	english	2016-08-25 15:13:07.512+08
1d2538a9-b69d-4fda-a26f-952fe96fdb28	Ibi, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ibi-spain-250px.jpg	f	english	2016-08-25 15:13:07.513+08
9c9967c6-7759-4e91-bdbd-cbefa0630238	Bergen, Norway	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bergen-norway-250px.jpg	f	english	2016-08-25 15:13:07.514+08
5c885e3d-d5c5-498f-887d-0151f3edf85e	Ciutadella, Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ciutadella-spain-250px.jpg	f	english	2016-08-25 15:13:07.515+08
3a686602-c929-4d98-b4ef-a5fc0a1fe746	Tirupur, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tirupur-india-250px.jpg	f	english	2016-08-25 15:13:07.516+08
0434a4b1-f2ad-436c-bd77-49b508a04c6b	Beersheba, Israel	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/beersheba-israel-250px.jpg	f	english	2016-08-25 15:13:07.517+08
7d5dc66c-8db0-4604-b023-4e6097f424bf	Rostov-on-Don, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/rostov-on-don-russia-250px.jpg	f	english	2016-08-25 15:13:07.518+08
fd4149ff-c80a-45c9-a5f8-147e2e49ab16	Bandar Seri Begawan, Brunei	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bandar-seri-begawan-brunei-250px.jpg	f	english	2016-08-25 15:13:07.519+08
df4be47d-0dd0-4e11-b942-ef240e43543a	Agadir, Morocco	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/agadir-morocco-250px.jpg	f	english	2016-08-25 15:13:07.52+08
8e2ba354-7f5c-42d3-b443-efa175177250	Venice, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/venice-italy-250px.jpg	f	english	2016-08-25 15:13:07.521+08
4eb12902-9330-4283-bfbc-c609af6ecdc6	Saint Helier, Jersey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/saint-helier-jersey-250px.jpg	f	english	2016-08-25 15:13:07.522+08
08fb29e1-c70a-4def-8433-4c72ff6e5769	Jerusalem, Israel	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jerusalem-israel-250px.jpg	f	english	2016-08-25 15:13:07.523+08
a763a085-8f6a-43b6-a528-4f482fea46d5	Antalya, Turkey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/antalya-turkey-250px.jpg	f	english	2016-08-25 15:13:07.524+08
3b8c42e4-1827-4dde-8fc5-a294774c7a57	Caye Caulker, Belize	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/caye-caulker-belize-250px.jpg	f	english	2016-08-25 15:13:07.525+08
811d84cc-6c65-48d9-9b7c-8f79644d2cb7	Urumqi, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/urumqi-china-250px.jpg	f	english	2016-08-25 15:13:07.526+08
6a429734-3876-4489-829d-b14fadd4c601	Salvador, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/salvador-brazil-250px.jpg	f	english	2016-08-25 15:13:07.527+08
270bdf52-48b2-491e-a4e6-1692cb4175ae	摄影	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	chinese	2016-08-25 15:13:12.849+08
f44d8cc1-6fb9-4c98-8d87-b140b46a238d	Nizhny, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nizhny-russia-250px.jpg	f	english	2016-08-25 15:13:07.528+08
7d81fdab-05d0-4291-9a87-175d7dc15f0e	Aarhus, Denmark	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/aarhus-denmark-250px.jpg	f	english	2016-08-25 15:13:07.53+08
410f2c5d-a4ae-4add-99e0-646bde9f60a1	Reading, United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/reading-united-kingdom-250px.jpg	f	english	2016-08-25 15:13:07.531+08
e6445149-28b4-4117-bfb1-0820af152401	Nairobi, Kenya	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nairobi-kenya-250px.jpg	f	english	2016-08-25 15:13:07.532+08
b5d90882-11f6-480a-9338-4b98ca8df972	Vitoria, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/vitoria-brazil-250px.jpg	f	english	2016-08-25 15:13:07.533+08
a0446b6b-d421-44c4-822c-fb2d59c90903	Naples, Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/naples-italy-250px.jpg	f	english	2016-08-25 15:13:07.534+08
7320bbb5-08b0-4257-87b9-ab8cee77201b	Guadalajara, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/guadalajara-mexico-250px.jpg	f	english	2016-08-25 15:13:07.535+08
fc005eb1-cc5b-491b-94c3-f488c076fe5f	Aalborg, Denmark	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/aalborg-denmark-250px.jpg	f	english	2016-08-25 15:13:07.536+08
97642f2d-9e89-4c27-8f1c-8c0de7617cfc	Abu Dhabi, United Arab Emirates	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/abu-dhabi-united-arab-emirates-250px.jpg	f	english	2016-08-25 15:13:07.539+08
88af8f16-010f-42b0-a7ce-31fc19950960	Bishkek, Kyrgyzstan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bishkek-kyrgyzstan-250px.jpg	f	english	2016-08-25 15:13:07.54+08
494f814e-bfb6-4ba3-b365-1c2454bce63d	Ankara, Turkey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ankara-turkey-250px.jpg	f	english	2016-08-25 15:13:07.542+08
c2b65d1d-dd4e-4a01-96bd-610bbca8f489	Manama, Bahrain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/manama-bahrain-250px.jpg	f	english	2016-08-25 15:13:07.543+08
b072c0ef-3145-4167-8539-4551b7559da0	Rosario, Argentina	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/rosario-argentina-250px.jpg	f	english	2016-08-25 15:13:07.544+08
92a3760f-bfc2-464d-a528-75daccddfbe9	Fez, Morocco	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/fez-morocco-250px.jpg	f	english	2016-08-25 15:13:07.545+08
c2dc744c-515e-4f57-b80e-5d6d144e4548	Dar es Salaam, Tanzania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dar-es-salaam-tanzania-250px.jpg	f	english	2016-08-25 15:13:07.546+08
3edc9bf2-65ed-4cf1-a52c-1e4b72ae266c	Vladivostok, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/vladivostok-russia-250px.jpg	f	english	2016-08-25 15:13:07.547+08
61f562a9-0c17-4e52-9baa-02c250a58df0	Beirut, Lebanon	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/beirut-lebanon-250px.jpg	f	english	2016-08-25 15:13:07.548+08
d487e702-60ca-4620-b6ce-eff93426e961	Rabat, Morocco	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/rabat-morocco-250px.jpg	f	english	2016-08-25 15:13:07.549+08
2cddea80-e438-4568-861e-c8523e10dfc2	Kota Kinabalu, Malaysia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kota-kinabalu-malaysia-250px.jpg	f	english	2016-08-25 15:13:07.55+08
92f753af-951a-454f-9dc4-4859742a5ab2	Recife, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/recife-brazil-250px.jpg	f	english	2016-08-25 15:13:07.551+08
036f6193-0cf3-4ac5-9842-0fb8420c94db	Arequipa, Peru	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/arequipa-peru-250px.jpg	f	english	2016-08-25 15:13:07.551+08
7a364366-45e7-4876-b9a5-03abf4506b17	Ko Tao, Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ko-tao-thailand-250px.jpg	f	english	2016-08-25 15:13:07.553+08
1d61f00d-97c0-49e1-bc39-60e2c8590e7a	Dubai, United Arab Emirates	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dubai-united-arab-emirates-250px.jpg	f	english	2016-08-25 15:13:07.554+08
761eb112-6e32-429e-8958-be690662f6b2	Mumbai, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/mumbai-india-250px.jpg	f	english	2016-08-25 15:13:07.555+08
e6510e2d-e306-4755-87b0-b14cb39a52f6	Nagpur, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nagpur-india-250px.jpg	f	english	2016-08-25 15:13:07.556+08
cf719e66-ea6f-4bcf-9bb9-6689c8b1f798	Siem Reap, Cambodia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/siem-reap-cambodia-250px.jpg	f	english	2016-08-25 15:13:07.557+08
4be0b6e6-340e-4152-85e2-6f1f76c5cdf2	Antigua, Guatemala	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/antigua-guatemala-250px.jpg	f	english	2016-08-25 15:13:07.558+08
2fd7278c-7bbe-4980-804f-18513bbf617c	Vientiane, Laos	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/vientiane-laos-250px.jpg	f	english	2016-08-25 15:13:07.559+08
1163b568-4a3c-4ca9-b336-769584cfd6fd	Cuenca, Ecuador	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cuenca-ecuador-250px.jpg	f	english	2016-08-25 15:13:07.56+08
6966923d-97e8-4f7d-adf3-f390e25a778c	Banja Luka, Bosnia-Herzegovina	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/banja-luka-bosnia-herzegovina-250px.jpg	f	english	2016-08-25 15:13:07.561+08
78d45664-7691-40b7-8179-2e8931497aad	Cochabamba, Bolivia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cochabamba-bolivia-250px.jpg	f	english	2016-08-25 15:13:07.562+08
dae5e08e-7f13-4680-905a-c9b8e496e833	Kalyan, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kalyan-india-250px.jpg	f	english	2016-08-25 15:13:07.563+08
a872cbb4-7060-4b33-bfe4-6a32d7e78732	Pune, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/pune-india-250px.jpg	f	english	2016-08-25 15:13:07.564+08
2f944946-4665-444d-9c87-2d2745fd0e49	Cape Town, South Africa	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cape-town-south-africa-250px.jpg	f	english	2016-08-25 15:13:07.565+08
0632ed31-c2e1-4456-b6ff-ca006571b532	Surat, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/surat-india-250px.jpg	f	english	2016-08-25 15:13:07.566+08
6567bcba-1154-4415-8d8c-31d8366869c6	Lucknow, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lucknow-india-250px.jpg	f	english	2016-08-25 15:13:07.568+08
41e33673-fa07-46d6-9e1d-7645a55ad39c	Santa Cruz, Bolivia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/santa-cruz-bolivia-250px.jpg	f	english	2016-08-25 15:13:07.569+08
c8bde57a-bb19-4a07-a7f6-644ccbc94078	Brazzaville, Congo	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/brazzaville-congo-250px.jpg	f	english	2016-08-25 15:13:07.57+08
868424cb-e15a-484f-bda1-6681a4394b88	Jaipur, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jaipur-india-250px.jpg	f	english	2016-08-25 15:13:07.57+08
ce6b379c-4b73-4f2f-bd83-a392b0a8a7ba	Hermosillo, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hermosillo-mexico-250px.jpg	f	english	2016-08-25 15:13:07.571+08
32719858-e416-4271-b4f8-36b0a58d691f	Bodrum, Turkey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bodrum-turkey-250px.jpg	f	english	2016-08-25 15:13:07.572+08
e4d9d952-682b-45df-ad08-a7b94b31a88d	Da Lat, Vietnam	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/da-lat-vietnam-250px.jpg	f	english	2016-08-25 15:13:07.573+08
c2215b68-2dc0-4ba5-ac98-9481b82c9bce	Cirebon, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cirebon-indonesia-250px.jpg	f	english	2016-08-25 15:13:07.574+08
14447d46-bca1-42ba-81a3-13ee422e95c4	Canada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ca.png	f	english	2016-08-25 15:13:10.422+08
d8bbe701-4d5f-4d06-8813-ca310a8945f4	Yogyakarta, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/yogyakarta-indonesia-250px.jpg	f	english	2016-08-25 15:13:07.575+08
ff7c111d-6c97-4131-acff-2031041fa63e	Phnom Penh, Cambodia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/phnom-penh-cambodia-250px.jpg	f	english	2016-08-25 15:13:07.576+08
1631aff0-a329-4f97-9f6d-6c91835d7e87	San Salvador, El Salvador	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/san-salvador-el-salvador-250px.jpg	f	english	2016-08-25 15:13:07.577+08
ccbd1306-da21-477d-876d-0cf5515395c2	Ahmedabad, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ahmedabad-india-250px.jpg	f	english	2016-08-25 15:13:07.578+08
1017e378-535b-4b8c-9bfc-0064c3daef2f	Yangon, Myanmar	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/yangon-myanmar-250px.jpg	f	english	2016-08-25 15:13:07.579+08
305dbeab-6134-4fa9-8452-d4f43e0394c8	Ko Phi Phi, Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ko-phi-phi-thailand-250px.jpg	f	english	2016-08-25 15:13:07.58+08
af19d7b8-8b7c-4319-a54e-6bff78bfd4d7	Jodhpur, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jodhpur-india-250px.jpg	f	english	2016-08-25 15:13:07.581+08
c0e6d480-3631-437f-a336-3c538d84cdc2	Ludhiana, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ludhiana-india-250px.jpg	f	english	2016-08-25 15:13:07.582+08
6f77f66d-fee9-49bc-8c96-474e57139c7a	Amritsar, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/amritsar-india-250px.jpg	f	english	2016-08-25 15:13:08.011+08
64eefc7d-cae3-4dd1-b7d9-e6e6e1647568	Tunis, Tunisia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tunis-tunisia-250px.jpg	f	english	2016-08-25 15:13:08.012+08
fb29ca40-510c-431f-991b-1e2739e2fba0	Bhopal, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bhopal-india-250px.jpg	f	english	2016-08-25 15:13:08.013+08
d14fa0cd-6de0-49ef-9b24-2d752174d129	Shantou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/shantou-china-250px.jpg	f	english	2016-08-25 15:13:08.014+08
35959045-0317-4673-aae3-c50c6312904c	Makassar, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/makassar-indonesia-250px.jpg	f	english	2016-08-25 15:13:08.015+08
d5f2562c-5b09-4a7a-ae11-763aaf43d0a9	Surabaya, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/surabaya-indonesia-250px.jpg	f	english	2016-08-25 15:13:08.016+08
a47bc7bb-2593-423e-b026-74f78f8c64e7	Nanjing, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nanjing-china-250px.jpg	f	english	2016-08-25 15:13:08.017+08
cb26ae3b-b368-4108-bcbd-c2a67a01bbae	Vadodara, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/vadodara-india-250px.jpg	f	english	2016-08-25 15:13:08.018+08
9b5020a3-c83c-4942-9f6d-78b083b1f5b7	Varanasi, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/varanasi-india-250px.jpg	f	english	2016-08-25 15:13:08.019+08
4cd4e8ec-abd4-4dab-a266-405f05e17d8f	Guangzhou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/guangzhou-china-250px.jpg	f	english	2016-08-25 15:13:08.02+08
f4291204-fa8e-4760-a946-6198064173fb	Chaoyang, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chaoyang-china-250px.jpg	f	english	2016-08-25 15:13:08.021+08
cc878670-7a3e-4206-a1d6-59eeae9f90ab	Tainan, Taiwan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tainan-taiwan-250px.jpg	f	english	2016-08-25 15:13:08.022+08
6e84e666-fe3e-4bb4-a1f3-45804e139fc1	Anshan, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/anshan-china-250px.jpg	f	english	2016-08-25 15:13:08.023+08
b98a5a0d-16e8-424f-ac95-9df43277c107	Rio de Janeiro, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/rio-de-janeiro-brazil-250px.jpg	f	english	2016-08-25 15:13:08.024+08
93ae34fa-3b14-4396-9a0d-f9eebafe9490	Taiyuan, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/taiyuan-china-250px.jpg	f	english	2016-08-25 15:13:08.025+08
3d9118c8-9f31-4d24-8797-eeaee88c7bc6	Foshan, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/foshan-china-250px.jpg	f	english	2016-08-25 15:13:08.026+08
423c1384-46f5-4bba-9249-dc20fe1d831c	Nasik, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nasik-india-250px.jpg	f	english	2016-08-25 15:13:08.027+08
c6509e1d-4a5f-4b02-b986-98b827b847ea	Nanchang, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nanchang-china-250px.jpg	f	english	2016-08-25 15:13:08.028+08
cdb448c8-9f1b-4b7f-a8b3-046847bde300	Manila, Philippines	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/manila-philippines-250px.jpg	f	english	2016-08-25 15:13:08.029+08
a51a2312-107c-4d89-967c-11fd5a5d29d4	Guatemala City, Guatemala	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/guatemala-city-guatemala-250px.jpg	f	english	2016-08-25 15:13:08.03+08
f8c9d577-ac11-4423-96c2-d12577365be6	Guayaquil, Ecuador	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/guayaquil-ecuador-250px.jpg	f	english	2016-08-25 15:13:08.031+08
28194be7-6d0b-423d-8e64-16d54db34ecf	Indore, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/indore-india-250px.jpg	f	english	2016-08-25 15:13:08.032+08
c94cb8cf-31ef-451d-beb6-3f181c9770f9	Pretoria, South Africa	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/pretoria-south-africa-250px.jpg	f	english	2016-08-25 15:13:08.033+08
1a9a6eb4-6670-4a6a-873a-1e4f7964525b	Kathmandu, Nepal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kathmandu-nepal-250px.jpg	f	english	2016-08-25 15:13:08.034+08
4bb23f97-f813-4da9-aab0-14e9971b1703	Lausanne, Switzerland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lausanne-switzerland-250px.jpg	f	english	2016-08-25 15:13:08.035+08
c697b450-4d4d-4249-9a21-7c8acdcc4da5	Bocas del Toro, Panama	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bocas-del-toro-panama-250px.jpg	f	english	2016-08-25 15:13:08.036+08
57c8246e-aaa9-4916-a0c1-e11c93052c8e	Belem, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/belem-brazil-250px.jpg	f	english	2016-08-25 15:13:08.037+08
54b84122-2f63-423b-b7a8-c9daef3a82dd	Qingdao, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/qingdao-china-250px.jpg	f	english	2016-08-25 15:13:08.038+08
21f471ed-4e21-4238-a301-46471b28c223	Linyi, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/linyi-china-250px.jpg	f	english	2016-08-25 15:13:08.039+08
2d9db3ce-cbee-4f25-9179-6ab53c1747dc	Doha, Qatar	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/doha-qatar-250px.jpg	f	english	2016-08-25 15:13:08.04+08
c365c8e9-874b-464b-8efc-67b7c01cede1	Bucaramanga, Colombia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bucaramanga-colombia-250px.jpg	f	english	2016-08-25 15:13:08.041+08
f5bc147a-4d13-4bb7-806d-cb5f9e3467dd	Kigali, Rwanda	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kigali-rwanda-250px.jpg	f	english	2016-08-25 15:13:08.042+08
1f49a22d-c47f-4a7d-8376-506be857feb0	Wenzhou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/wenzhou-china-250px.jpg	f	english	2016-08-25 15:13:08.043+08
0a810c84-062b-4e5f-830a-d28800e0691f	Shenyang, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/shenyang-china-250px.jpg	f	english	2016-08-25 15:13:08.043+08
3ce19751-e0f1-474c-8f5c-10b6e784e780	Penang, Malaysia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/penang-malaysia-250px.jpg	f	english	2016-08-25 15:13:08.044+08
3fa0d329-fa62-41d2-a911-7562d441f830	Frankfurt, Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/frankfurt-germany-250px.jpg	f	english	2016-08-25 15:13:08.045+08
b448cec9-27a8-4dc9-981e-b7b240b3d16d	Wuhan, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/wuhan-china-250px.jpg	f	english	2016-08-25 15:13:08.046+08
7ad98b74-54b5-4f7e-9c87-b162621ab3e5	Port Elizabeth, South Africa	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/port-elizabeth-south-africa-250px.jpg	f	english	2016-08-25 15:13:08.047+08
ca48d0ed-81cd-4d17-a8b4-73d815442a46	Abidjan, Ivory Coast	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/abidjan-ivory-coast-250px.jpg	f	english	2016-08-25 15:13:08.048+08
0e069740-be30-4148-a86e-cbba3e62d7f6	Samara, Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/samara-russia-250px.jpg	f	english	2016-08-25 15:13:08.049+08
8e840154-9607-47b8-9e5a-2e5b15a8d61f	Xuzhou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/xuzhou-china-250px.jpg	f	english	2016-08-25 15:13:08.049+08
2a0c0791-ed0b-4d87-9958-d785a6552725	Cebu, Philippines	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cebu-philippines-250px.jpg	f	english	2016-08-25 15:13:08.05+08
d8d93129-0c45-46da-8792-29fd0a7f2f3c	Semarang, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/semarang-indonesia-250px.jpg	f	english	2016-08-25 15:13:08.051+08
b143de59-de50-49b6-afc5-0d270f5d1fa4	Agra, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/agra-india-250px.jpg	f	english	2016-08-25 15:13:08.052+08
e70d29b0-19a1-4348-9eb5-9ef3a29a336a	Chicago, United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chicago-il-united-states-250px.jpg	f	english	2016-08-25 15:13:08.052+08
4a56f5dd-cae7-4d2a-8e8a-b4cd82f20769	Jeddah, Saudi Arabia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jeddah-saudi-arabia-250px.jpg	f	english	2016-08-25 15:13:08.053+08
61a7f2c4-76c2-45b3-ad21-dff690dc0aae	Tashkent, Uzbekistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tashkent-uzbekistan-250px.jpg	f	english	2016-08-25 15:13:08.054+08
263a2a7c-482b-417d-a5a1-9dfa4e083c74	Haikou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/haikou-china-250px.jpg	f	english	2016-08-25 15:13:08.054+08
7475ec92-6f6b-4a97-9026-6ba9f303dff6	Chongqing, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chongqing-china-250px.jpg	f	english	2016-08-25 15:13:08.055+08
2b046cac-2e4f-4a20-97f3-badb49e720b1	Allahabad, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/allahabad-india-250px.jpg	f	english	2016-08-25 15:13:08.056+08
649b0db9-da34-40b7-a0bf-47e987fbe8fa	Maputo, Mozambique	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/maputo-mozambique-250px.jpg	f	english	2016-08-25 15:13:08.411+08
7f89140d-546d-4af6-9d78-da2de1feeec7	Harbin, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/harbin-china-250px.jpg	f	english	2016-08-25 15:13:08.412+08
e8cef93c-5282-4be5-b8e9-f41311cc6001	Guiyang, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/guiyang-china-250px.jpg	f	english	2016-08-25 15:13:08.413+08
a956b348-568c-4892-8cea-f31972e9d240	Quanzhou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/quanzhou-china-250px.jpg	f	english	2016-08-25 15:13:08.414+08
b81995d1-3e69-451a-b2e8-cdd7e9cc797b	General Santos, Philippines	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/general-santos-philippines-250px.jpg	f	english	2016-08-25 15:13:08.415+08
04f767c3-aaf5-4c32-a01b-4a2ef537fe52	Changsha, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/changsha-china-250px.jpg	f	english	2016-08-25 15:13:08.416+08
c1f270ef-ea1a-40d9-96a2-5fd1a3606623	Salento, Colombia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/salento-colombia-250px.jpg	f	english	2016-08-25 15:13:08.417+08
57485cc9-5c7b-4df1-ad34-ae3d956b9f3c	Kochi, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kochi-india-250px.jpg	f	english	2016-08-25 15:13:08.418+08
3d5aa3cd-014d-4ece-aad9-e449df56dbd9	Odesa, Ukraine	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/odesa-ukraine-250px.jpg	f	english	2016-08-25 15:13:08.419+08
176d4da6-c6dc-4df4-a6e5-67b8a9911411	Makati, Philippines	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/makati-philippines-250px.jpg	f	english	2016-08-25 15:13:08.42+08
5dd4f3d1-1ba0-41a8-bbc2-26b117de60e8	Aurangabad, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/aurangabad-india-250px.jpg	f	english	2016-08-25 15:13:08.421+08
99e21927-1e1d-430e-abe0-2a88b98174d3	Adana, Turkey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/adana-turkey-250px.jpg	f	english	2016-08-25 15:13:08.422+08
367633f7-e937-44b7-828a-60b47da98071	Baoding, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/baoding-china-250px.jpg	f	english	2016-08-25 15:13:08.423+08
720e4275-21a5-449a-b231-dfb68acbc303	Male, Maldives	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/male-maldives-250px.jpg	f	english	2016-08-25 15:13:08.424+08
72b2b7f8-67f4-4f5d-82eb-2eaad003e0a8	Weihai, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/weihai-china-250px.jpg	f	english	2016-08-25 15:13:08.425+08
8231eb0e-f825-4a42-a622-f738f5df5986	Kunming, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kunming-china-250px.jpg	f	english	2016-08-25 15:13:08.425+08
e9e1df70-2510-470d-9dd7-418b231b3852	Shijiazhuang, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/shijiazhuang-china-250px.jpg	f	english	2016-08-25 15:13:08.426+08
00e2ef8d-4520-4452-a65c-625f8c338362	Zhengzhou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/zhengzhou-china-250px.jpg	f	english	2016-08-25 15:13:08.427+08
07076743-e83f-4562-afa8-3a53a519218a	Barranquilla, Colombia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/barranquilla-colombia-250px.jpg	f	english	2016-08-25 15:13:08.428+08
7d260a0f-c7ab-4bb9-8148-6f12998f718f	Tangshan, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tangshan-china-250px.jpg	f	english	2016-08-25 15:13:08.428+08
be7eea9d-1db9-4a24-b534-2770da0a2d46	Coimbatore, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/coimbatore-india-250px.jpg	f	english	2016-08-25 15:13:08.429+08
fe4aa27d-716a-47e6-894a-94c99bb978ac	Qinhuangdao, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/qinhuangdao-china-250px.jpg	f	english	2016-08-25 15:13:08.43+08
41209257-f1d0-42c8-a0d5-2a015eff254d	Bamako, Mali	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bamako-mali-250px.jpg	f	english	2016-08-25 15:13:08.43+08
5b070d62-522f-420c-aa4d-d56f6ffca32c	Belize City, Belize	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/belize-city-belize-250px.jpg	f	english	2016-08-25 15:13:08.431+08
705353e7-86a0-46da-ab53-2234dbaa4dad	Jabalpur, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jabalpur-india-250px.jpg	f	english	2016-08-25 15:13:08.432+08
7faa4ad9-c6b3-4527-910f-a6502d716d1d	El Jadida, Morocco	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/el-jadida-morocco-250px.jpg	f	english	2016-08-25 15:13:08.433+08
e48ecef7-d279-4192-abfe-e2eb4263a8cd	Jiamusi, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jiamusi-china-250px.jpg	f	english	2016-08-25 15:13:08.433+08
6625262b-0aa3-4880-be0e-6fff55d597df	Goa, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/goa-india-250px.jpg	f	english	2016-08-25 15:13:08.434+08
e41547d9-81d4-4687-9c2a-570023ed6142	Windhoek, Namibia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/windhoek-namibia-250px.jpg	f	english	2016-08-25 15:13:08.436+08
210e1ee6-e6c7-4229-a12d-aa84e1015128	Mauritius	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mu.png	f	english	2016-08-25 15:13:11.219+08
a3e4ac29-7b5f-4054-b1bc-036bccef85e3	Dushanbe, Tajikistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dushanbe-tajikistan-250px.jpg	f	english	2016-08-25 15:13:08.437+08
81918e81-2d86-446a-9353-5e4df56abee9	Cixi, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cixi-china-250px.jpg	f	english	2016-08-25 15:13:08.438+08
f1fc58a9-2ceb-4050-8570-c86f7b3e2fe4	Guwahati, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/guwahati-india-250px.jpg	f	english	2016-08-25 15:13:08.439+08
1fdf36ba-823b-4668-b0f4-d88d7abfa348	Muscat, Oman	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/muscat-oman-250px.jpg	f	english	2016-08-25 15:13:08.44+08
ab83edf9-4402-48e6-9844-d3a6d34d6c6d	Kunshan, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kunshan-china-250px.jpg	f	english	2016-08-25 15:13:08.441+08
051a3c4e-e4d6-43ae-abad-f81e33fcce5d	Handan, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/handan-china-250px.jpg	f	english	2016-08-25 15:13:08.443+08
61e5df1d-595e-4ddb-af3c-5997aba76459	Jiangmen, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jiangmen-china-250px.jpg	f	english	2016-08-25 15:13:08.445+08
fb338916-b573-423c-a94a-0a29495e0bde	Changchun, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/changchun-china-250px.jpg	f	english	2016-08-25 15:13:08.446+08
ba58d6c0-5590-47c9-87aa-d4798c9beb2b	Putian, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/putian-china-250px.jpg	f	english	2016-08-25 15:13:08.447+08
0e0001f0-3cf2-4cd8-aff3-1409513880bd	Jinan, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jinan-china-250px.jpg	f	english	2016-08-25 15:13:08.448+08
1a60bf90-ed0b-4add-b8d6-f7632b90a8be	Kampala, Uganda	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kampala-uganda-250px.jpg	f	english	2016-08-25 15:13:08.449+08
1e31ef75-2de9-4be9-a9af-55ba4203cc6e	Dammam, Saudi Arabia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dammam-saudi-arabia-250px.jpg	f	english	2016-08-25 15:13:08.45+08
a095a372-3c5e-4eff-95a2-d32474b90ac9	Kinshasa, DR Congo	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kinshasa-dr-congo-250px.jpg	f	english	2016-08-25 15:13:08.451+08
6750802b-9834-4993-8d0c-9f16d8d33f2d	Huizhou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/huizhou-china-250px.jpg	f	english	2016-08-25 15:13:08.452+08
57d0310e-1089-4f35-94f8-55066ba340b6	Paphos, Cyprus	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/paphos-cyprus-250px.jpg	f	english	2016-08-25 15:13:08.453+08
572ff9ef-d049-42da-a2e3-6d73a5a40336	Santa Marta, Colombia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/santa-marta-colombia-250px.jpg	f	english	2016-08-25 15:13:08.454+08
9cecf909-d46f-431f-bddd-8ed53ab4ac8e	Chittagong, Bangladesh	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chittagong-bangladesh-250px.jpg	f	english	2016-08-25 15:13:08.455+08
7017c0d0-a4f9-4aac-bb66-671ab26ddcf7	Hefei, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hefei-china-250px.jpg	f	english	2016-08-25 15:13:08.456+08
29be4f48-a345-4a77-85cb-00472371597c	Fuzhou, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/fuzhou-china-250px.jpg	f	english	2016-08-25 15:13:08.457+08
fe09b4ab-4b1e-4ef3-88ba-9163b41aca95	Joao Pessoa, Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/joao-pessoa-brazil-250px.jpg	f	english	2016-08-25 15:13:08.458+08
dcb1b22c-430f-47ac-867c-30bd41d7c7d2	Durban, South Africa	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/durban-south-africa-250px.jpg	f	english	2016-08-25 15:13:08.815+08
6a0e40ea-7a70-4fa6-8302-70615e528258	Sulaymaniyah, Kurdistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/sulaymaniyah-kurdistan-250px.jpg	f	english	2016-08-25 15:13:08.817+08
d2385c67-c8c0-4815-8952-555ff3ee0d9e	Hohhot, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hohhot-china-250px.jpg	f	english	2016-08-25 15:13:08.818+08
00539e68-fb80-473b-8815-55d7cedda733	Zhuhai, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/zhuhai-china-250px.jpg	f	english	2016-08-25 15:13:08.819+08
af1849ed-f83d-4fe9-a6bc-36d8b2062392	San Pedro, Belize	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/san-pedro-belize-250px.jpg	f	english	2016-08-25 15:13:08.82+08
3c2d9228-32e0-4484-b3f5-7f52b82fbb98	Chandigarh, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/chandigarh-india-250px.jpg	f	english	2016-08-25 15:13:08.822+08
487be777-8426-4713-acf9-5a4e1bf372f0	Kolkata, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kolkata-india-250px.jpg	f	english	2016-08-25 15:13:08.823+08
c7a6e657-5fbc-4cda-bd8d-15f6fd28a9d4	Hamilton, Bermuda	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/hamilton-bermuda-250px.jpg	f	english	2016-08-25 15:13:08.824+08
1c7abd47-522b-44c2-b82e-37db6d70aac4	Pai, Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/pai-thailand-250px.jpg	f	english	2016-08-25 15:13:08.824+08
eddf7456-8079-482e-806d-dec6cb1c7905	Tehran, Iran	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tehran-iran-250px.jpg	f	english	2016-08-25 15:13:08.826+08
92e69789-ba92-487a-8fec-abd4e6474e7d	Alexandria, Egypt	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/alexandria-egypt-250px.jpg	f	english	2016-08-25 15:13:08.826+08
61236754-4061-4f69-8bfe-979ab047ec33	Yantai, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/yantai-china-250px.jpg	f	english	2016-08-25 15:13:08.828+08
10ec2efb-2f0a-4484-9934-d6363f2a8952	Antananarivo, Madagascar	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/antananarivo-madagascar-250px.jpg	f	english	2016-08-25 15:13:08.828+08
2088b12c-b373-4e43-9315-c2636ac0c4c1	Xiamen, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/xiamen-china-250px.jpg	f	english	2016-08-25 15:13:08.829+08
cca75a4b-8323-4888-80d7-57cf1e904a36	Riyadh, Saudi Arabia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/riyadh-saudi-arabia-250px.jpg	f	english	2016-08-25 15:13:08.83+08
993cbf40-c768-4276-9d2d-d56d98624304	Port Said, Egypt	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/port-said-egypt-250px.jpg	f	english	2016-08-25 15:13:08.831+08
4825429b-9989-4a78-8c96-67c4928d4efe	Gwalior, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/gwalior-india-250px.jpg	f	english	2016-08-25 15:13:08.832+08
d3897136-9c47-4d8e-8b2d-c847f3cc254e	Khulna, Bangladesh	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/khulna-bangladesh-250px.jpg	f	english	2016-08-25 15:13:08.833+08
a883c4b5-e008-4704-8a1e-c0706585f425	Huai'an, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/huaian-china-250px.jpg	f	english	2016-08-25 15:13:08.834+08
10a6f112-0b3e-4eec-93bc-400bad2db279	Kollam, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kollam-india-250px.jpg	f	english	2016-08-25 15:13:08.834+08
6e24bae6-55d3-4f50-9958-a69b63c86377	Haifa, Israel	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/haifa-israel-250px.jpg	f	english	2016-08-25 15:13:08.835+08
c6ebeb78-7879-424c-863e-aeddf5c18f07	Lahore, Pakistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lahore-pakistan-250px.jpg	f	english	2016-08-25 15:13:08.836+08
fc67f661-e539-4784-8d35-21c17be58f50	Addis Ababa, Ethiopia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/addis-ababa-ethiopia-250px.jpg	f	english	2016-08-25 15:13:08.837+08
c2fe3e1a-51ea-46e4-8e9c-781b5c16f407	Jiaxing, China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jiaxing-china-250px.jpg	f	english	2016-08-25 15:13:08.837+08
faf04597-f90f-4adf-bd74-8a2d2e4a7f90	Jamshedpur, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/jamshedpur-india-250px.jpg	f	english	2016-08-25 15:13:08.838+08
5265b0cc-11fe-40b1-9664-5757ff3903b3	Kota, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kota-india-250px.jpg	f	english	2016-08-25 15:13:08.839+08
20776692-4c2e-4b2a-a92c-158f6b89bba8	Ibadan, Nigeria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/ibadan-nigeria-250px.jpg	f	english	2016-08-25 15:13:08.84+08
da213fcd-10ee-4306-bef0-d30d5689626e	Asansol, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/asansol-india-250px.jpg	f	english	2016-08-25 15:13:08.84+08
bea000bc-8507-4418-936f-a59775c11e16	Bogota, Colombia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bogota-colombia-250px.jpg	f	english	2016-08-25 15:13:08.841+08
695127f8-aa50-4b43-a71e-f782f0449fc3	Lagos, Nigeria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/lagos-nigeria-250px.jpg	f	english	2016-08-25 15:13:08.842+08
459321bb-2e48-4e2c-96ab-b13930ce2f63	Kannur, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kannur-india-250px.jpg	f	english	2016-08-25 15:13:08.843+08
8d889f60-710b-4aae-a30e-99cd1ad27879	Erbil, Kurdistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/erbil-kurdistan-250px.jpg	f	english	2016-08-25 15:13:08.844+08
c77ba73f-2360-4e9e-9278-99c665bcc820	Dhanbad, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dhanbad-india-250px.jpg	f	english	2016-08-25 15:13:08.845+08
017828ce-df01-4311-afb6-851e2c200e6b	Batam, Philippines	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/batam-philippines-250px.jpg	f	english	2016-08-25 15:13:08.845+08
98172ce2-d3c9-463e-81a9-b1eb5daa2155	Mysore, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/mysore-india-250px.jpg	f	english	2016-08-25 15:13:08.846+08
9e432f39-3401-4985-b2d8-98afd1e0672d	Accra, Ghana	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/accra-ghana-250px.jpg	f	english	2016-08-25 15:13:08.847+08
9d518d2c-ddb3-4127-9905-ce6ac7d006a0	Kano, Nigeria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kano-nigeria-250px.jpg	f	english	2016-08-25 15:13:08.848+08
c1165f93-7171-4e3d-84a7-5bfe875c9480	Abuja, Nigeria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/abuja-nigeria-250px.jpg	f	english	2016-08-25 15:13:08.848+08
c25be4d5-38bd-471f-9b5d-a94abbd8b009	Kanpur, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kanpur-india-250px.jpg	f	english	2016-08-25 15:13:08.849+08
748a2a77-20f9-483e-b691-0dc414793138	Dhaka, Bangladesh	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/dhaka-bangladesh-250px.jpg	f	english	2016-08-25 15:13:08.85+08
65c76457-f291-4319-bccd-2c36744016cc	Kozhikode, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/kozhikode-india-250px.jpg	f	english	2016-08-25 15:13:08.851+08
1e6ad7da-3ab1-4caf-8e2c-db1d568908ad	Islamabad, Pakistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/islamabad-pakistan-250px.jpg	f	english	2016-08-25 15:13:08.852+08
2d371ec8-ff07-4c34-92d5-39a127d8a439	Nashik, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/nashik-india-250px.jpg	f	english	2016-08-25 15:13:08.853+08
87628b82-bc82-4dce-af22-702f86122e61	Conakry, Guinea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/conakry-guinea-250px.jpg	f	english	2016-08-25 15:13:08.854+08
c15f87bb-9d7e-4614-952c-02a245f2e583	Faisalabad, Pakistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/faisalabad-pakistan-250px.jpg	f	english	2016-08-25 15:13:08.854+08
0cf80d6d-8a3a-4788-84cd-19332df627da	La Paz, Bolivia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/la-paz-bolivia-250px.jpg	f	english	2016-08-25 15:13:08.855+08
d6399464-2af6-40f8-9d50-59579ce02dcc	Madurai, India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/madurai-india-250px.jpg	f	english	2016-08-25 15:13:08.856+08
a5636058-b07f-40cf-9f82-a3f28b03605e	Isfahan, Iran	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/isfahan-iran-250px.jpg	f	english	2016-08-25 15:13:08.857+08
a7b00a51-e317-4f94-9924-5744399dad71	Johannesburg, South Africa	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/johannesburg-south-africa-250px.jpg	f	english	2016-08-25 15:13:08.858+08
30cc8953-2aae-4391-bbef-76b559cfcdc1	Harare, Zimbabwe	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/harare-zimbabwe-250px.jpg	f	english	2016-08-25 15:13:08.859+08
6f7154e5-75fa-495d-81c2-f08a46529a39	Khartoum, Sudan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/khartoum-sudan-250px.jpg	f	english	2016-08-25 15:13:09.215+08
9c1a4daa-a818-4533-a11d-943cba4a9ccd	Algiers, Algeria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/algiers-algeria-250px.jpg	f	english	2016-08-25 15:13:09.217+08
786619b6-7b63-4a01-b0fb-cd75ce3f66ef	Aguascalientes, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/aguascalientes-mexico-250px.jpg	f	english	2016-08-25 15:13:09.218+08
4d8094b1-bfe0-4210-940b-633556d2333d	Toluca, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/toluca-mexico-250px.jpg	f	english	2016-08-25 15:13:09.219+08
cd4b42eb-e118-4121-9fe2-f3804933fca5	Tegucigalpa, Honduras	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/tegucigalpa-honduras-250px.jpg	f	english	2016-08-25 15:13:09.22+08
e131b4a9-6af0-49c1-9fa4-335e118ad5d8	Caracas, Venezuela	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/caracas-venezuela-250px.jpg	f	english	2016-08-25 15:13:09.221+08
502acf5a-3cea-45e6-a934-a6900d1ffdf0	Huambo, Angola	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/huambo-angola-250px.jpg	f	english	2016-08-25 15:13:09.223+08
bf218c4d-ec2f-4c73-81d1-d270d6d8423a	Rawalpindi, Pakistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/rawalpindi-pakistan-250px.jpg	f	english	2016-08-25 15:13:09.224+08
884574d2-a072-47f0-87d5-b1832cd04fce	Torreon, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/torreon-mexico-250px.jpg	f	english	2016-08-25 15:13:09.225+08
63de9931-d494-4f9c-a066-bcccd5318415	Karachi, Pakistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/karachi-pakistan-250px.jpg	f	english	2016-08-25 15:13:09.226+08
9a373219-0ed4-47ae-b8bf-c7fd9d98a88a	Port Moresby, Papua New Guinea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/port-moresby-papua-new-guinea-250px.jpg	f	english	2016-08-25 15:13:09.227+08
c05fda3c-e5d8-4300-bd28-656d715f9e8e	Puebla, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/puebla-mexico-250px.jpg	f	english	2016-08-25 15:13:09.228+08
b7891d6b-492c-4c2d-aaed-d405c42154fe	Luanda, Angola	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/luanda-angola-250px.jpg	f	english	2016-08-25 15:13:09.229+08
2a160d33-25bb-41f1-b6b0-97bf3915f9f1	Gujranwala, Pakistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/gujranwala-pakistan-250px.jpg	f	english	2016-08-25 15:13:09.23+08
53097ccf-aed4-4343-be55-7de11a83662e	Bahawalpur, Pakistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/bahawalpur-pakistan-250px.jpg	f	english	2016-08-25 15:13:09.231+08
6ee12d01-2b83-47fd-ba0a-e50fb93d5f7c	Juarez, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/juarez-mexico-250px.jpg	f	english	2016-08-25 15:13:09.232+08
c90ed302-d90c-48a2-b183-9fc2a7013abb	San Luis Potosi, Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/san-luis-potosi-mexico-250px.jpg	f	english	2016-08-25 15:13:09.233+08
2dc5edf6-590f-488f-894d-d2d66c8301e6	Damascus, Syria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/damascus-syria-250px.jpg	f	english	2016-08-25 15:13:09.234+08
ca736699-a30a-4fb1-b8be-4d851674864e	Cali, Colombia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/cali-colombia-250px.jpg	f	english	2016-08-25 15:13:09.236+08
a82c3b9a-a764-4e32-acf6-d4225b944503	Pyongyang, North Korea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/pyongyang-north-korea-250px.jpg	f	english	2016-08-25 15:13:09.237+08
eabe8c5d-0e2e-447e-9705-d2aa091891a1	Baghdad, Iraq	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/baghdad-iraq-250px.jpg	f	english	2016-08-25 15:13:09.238+08
3ecab313-b40a-4536-ac8a-63a20cf3d8ed	Pekanbaru, Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/pekanbaru-sumatra-indonesia-250px.jpg	f	english	2016-08-25 15:13:09.239+08
0e4508f1-cfe3-4e11-98c5-981a4401a89d	Basra, Iraq	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/basra-iraq-250px.jpg	f	english	2016-08-25 15:13:09.24+08
6b5ed14b-fce2-499a-9c53-a24343b7cddf	Konya, Turkey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	https://nomadlist.com/assets/img/cities/konya-turkey-250px.jpg	f	english	2016-08-25 15:13:09.24+08
a7f509ce-bf17-4012-8766-19d06f0d9311	云南	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.241+08
dd9e73c7-b2b0-4484-9a7f-1603bd2c1c3c	西藏	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.242+08
22062c38-8557-47aa-8adf-6708ad18493b	台湾	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.244+08
764b5a32-6ac5-4347-a5af-4dad9a8e6b2f	香港	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.245+08
c743b0ea-f17f-429e-8832-54d9c0c50ad7	新疆	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.245+08
6ac5bdc3-8417-4061-9e7b-26c8e80f46ef	成都	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.246+08
d2631eea-284f-4016-9401-935ffeef761e	青岛	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.247+08
b7d7ef7d-5a82-45cd-bb26-e2e700dce1e6	杭州	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.248+08
30f29949-20c9-488c-b092-522d5300391c	广州	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.249+08
0972c2b4-212f-427f-93eb-a2b8951c7560	上海	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.251+08
b006d47d-15b3-4795-92e7-eaf2e25bd94d	北京	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	place	\N	f	chinese	2016-08-25 15:13:09.253+08
17b50b9d-33d3-4255-8b25-f830c65d0c25	Golden State Warriors	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_golden_state_warriors.jpg	f	english	2016-08-25 15:13:09.256+08
aa7a1470-0a48-45f3-bf53-d2e29c296fa0	Cleveland Cavaliers	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_cleveland_cavaliers.jpg	f	english	2016-08-25 15:13:09.261+08
6c268930-cfaf-460c-b35d-ea5613f68e27	Los Angeles Lakers	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_los_angeles_lakers.jpg	f	english	2016-08-25 15:13:09.262+08
0a15c5a8-f7d5-465e-9777-35f09938e901	Toronto Raptors	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_toronto_raptors.jpg	f	english	2016-08-25 15:13:09.265+08
8a86a972-41bb-4a78-8b8d-2e185c6df55f	New York Knicks	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_new_york_knicks.jpg	f	english	2016-08-25 15:13:09.266+08
ec169b4c-d063-4cc8-b5a7-577dc375feac	Boston Celtics	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_boston_celtics.jpg	f	english	2016-08-25 15:13:09.267+08
5d569a69-2d83-4db5-ae2f-fb32415374cc	Miami Heat	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_miami_heat.jpg	f	english	2016-08-25 15:13:09.268+08
05baabd2-5392-4c6e-8c48-1255b7e99ac7	Oklahoma City Thunder	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_oklahoma_city_thunder.jpg	f	english	2016-08-25 15:13:09.269+08
f268835d-8c0c-4d1c-a511-c65897b19b75	Chicago Bulls	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_chicago_bulls.jpg	f	english	2016-08-25 15:13:09.271+08
8f29fa3e-f55a-49a7-a3eb-6354e1a5fb13	Philadelphia 76ers	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_philadelphia_76ers.jpg	f	english	2016-08-25 15:13:09.274+08
7ebd2b43-3e36-4cea-9afa-b1103875dc1e	Houston Rockets	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_houston_rockets.jpg	f	english	2016-08-25 15:13:09.275+08
83bc8b62-e396-454c-a512-9a594319d837	Los Angeles Clippers	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_los_angeles_clippers.jpg	f	english	2016-08-25 15:13:09.276+08
7fb03eb7-4c29-4b3b-82ba-9d6e3ff05383	Dallas Mavericks	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_dallas_mavericks.jpg	f	english	2016-08-25 15:13:09.277+08
b963a717-4e6d-42f0-82bf-6fec4edd395e	Portland Trail Blazers	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_portland_trail_blazers.jpg	f	english	2016-08-25 15:13:09.278+08
0905fc3a-1118-4ef5-8ce6-1f425f024a7d	Sacramento Kings	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_sacramento_kings.jpg	f	english	2016-08-25 15:13:09.614+08
cde134fe-2aad-402a-b5e2-bbbc257a07f2	Minnesota Timberwolves	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_minnesota_timberwolves.jpg	f	english	2016-08-25 15:13:09.615+08
5194f1a4-f2f1-468d-b546-f21c11c529fe	New Orleans Pelicans	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_new_orleans_pelicans.jpg	f	english	2016-08-25 15:13:09.616+08
0615e34d-4413-40f8-a14c-6e2e8a148000	Brooklyn Nets	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_brooklyn_nets.jpg	f	english	2016-08-25 15:13:09.617+08
1d86e93b-b264-4519-80eb-7db685afb0a4	Indiana Pacers	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_indiana_pacers.jpg	f	english	2016-08-25 15:13:09.618+08
607513a9-ddc0-44b7-b64e-f4d03cd8b3f5	Atlanta Hawks	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_atlanta_hawks.jpg	f	english	2016-08-25 15:13:09.619+08
a187307d-37ee-48fe-ad4e-057d18453822	Phoenix Suns	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_phoenix_suns.jpg	f	english	2016-08-25 15:13:09.621+08
3ac29864-9a56-4498-b36c-bde504bfb34d	Charlotte Hornets	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_charlotte_hornets.jpg	f	english	2016-08-25 15:13:09.622+08
f7286f9a-a82e-4d1d-acea-08b1f08064c0	Detroit Pistons	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_detroit_pistons.jpg	f	english	2016-08-25 15:13:09.622+08
0fc40544-a4c4-4f1b-a839-9655223c6642	Milwaukee Bucks	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_milwaukee_bucks.jpg	f	english	2016-08-25 15:13:09.623+08
65b1b3ec-f146-4a3b-bffb-b4ada2a6ad22	Washington Wizards	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_washington_wizards.jpg	f	english	2016-08-25 15:13:09.624+08
3b3bac54-a98f-41fa-a1f8-f066d6e37c45	Utah Jazz	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_utah_jazz.jpg	f	english	2016-08-25 15:13:09.625+08
528c688e-fbd6-410b-b663-ad8b3337aae4	Memphis Grizzlies	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_memphis_grizzlies.jpg	f	english	2016-08-25 15:13:09.626+08
5e5c864d-cf14-4e17-9329-e88e9e5e3f84	Denver Nuggets	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_denver_nuggets.jpg	f	english	2016-08-25 15:13:09.627+08
efe4b45e-9d61-43c8-85c2-aa9cfa136f1d	Orlando Magic	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	nba	https://s3.amazonaws.com/lymchat/pics/college_orlando_magic.jpg	f	english	2016-08-25 15:13:09.628+08
37dcc6c8-2fe2-4f1e-bca7-1514778b9f76	Manchester United F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_manchester_united_f.c..jpg	f	english	2016-08-25 15:13:09.629+08
399691cb-9748-4169-a10c-e7d1fe1969b8	Movie	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	english	2016-08-25 15:13:12.836+08
b69bd7cd-10de-4821-a4dc-b033bd55ca15	Arsenal F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_arsenal_f.c..jpg	f	english	2016-08-25 15:13:09.63+08
31d66b04-ed42-4176-924a-fed10f1eabe4	Chelsea F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_chelsea_f.c..jpg	f	english	2016-08-25 15:13:09.631+08
ade97ade-3870-4113-bc5b-1a8948683f53	Real Madrid C.F.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_real_madrid_c.f..jpg	f	english	2016-08-25 15:13:09.632+08
48ef8502-0268-4f6d-b0c7-1fce21f61ecb	Manchester City F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_manchester_city_f.c..jpg	f	english	2016-08-25 15:13:09.633+08
761cc3cc-63e9-4d7f-ab89-e1424bd3ed1f	Liverpool F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_liverpool_f.c..jpg	f	english	2016-08-25 15:13:09.634+08
725d8cef-267a-497e-8cae-3811b749798f	Tottenham Hotspur F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_tottenham_hotspur_f.c..jpg	f	english	2016-08-25 15:13:09.635+08
57372367-8462-41d3-81f3-b0503b1bb0e0	FC Bayern Munich	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_fc_bayern_munich.jpg	f	english	2016-08-25 15:13:09.637+08
16f07714-f41f-4d67-90dc-c7f9689bf441	Juventus F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_juventus_f.c..jpg	f	english	2016-08-25 15:13:09.638+08
ceaa772b-c0b4-4cb7-a160-900668ae0b1c	Paris Saint-Germain F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_paris_saint-germain_f.c..jpg	f	english	2016-08-25 15:13:09.64+08
bb0ec42e-cdf7-43aa-b016-2dacdccea37b	Atlético Madrid	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_atlético_madrid.jpg	f	english	2016-08-25 15:13:09.641+08
c2b18e6f-ef28-471c-ae0e-1762fb5b589e	West Ham United F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_west_ham_united_f.c..jpg	f	english	2016-08-25 15:13:09.642+08
a394b1a7-6582-4b13-876f-4b1ad6af0b15	Borussia Dortmund	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_borussia_dortmund.jpg	f	english	2016-08-25 15:13:09.643+08
277df02f-b845-4286-af7a-fafc7f999b99	Everton F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_everton_f.c..jpg	f	english	2016-08-25 15:13:09.645+08
63584658-0e31-41b0-b3ca-52c82b393bd4	A.C. Milan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_a.c._milan.jpg	f	english	2016-08-25 15:13:09.646+08
85b30a80-98db-42a4-abf1-8418e2bb2872	Leicester City F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_leicester_city_f.c..jpg	f	english	2016-08-25 15:13:09.647+08
f1a29013-99d7-40ca-8033-2b0f36af2d17	Germany national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_germany_national_football_team.jpg	f	english	2016-08-25 15:13:09.648+08
ed3a5d64-6be2-4044-b980-288e3675a6e6	England national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_england_national_football_team.jpg	f	english	2016-08-25 15:13:09.649+08
73d9b6d3-b10a-4b9a-9f27-d0a4f1554064	FC Schalke 04	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_fc_schalke_04.jpg	f	english	2016-08-25 15:13:09.65+08
bbbaf064-4642-4fcc-a906-8826054b9d41	West Bromwich Albion F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_west_bromwich_albion_f.c..jpg	f	english	2016-08-25 15:13:09.651+08
e7eb4121-a1d8-469d-8b08-2a3d2efbd5d1	Portugal national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_portugal_national_football_team.jpg	f	english	2016-08-25 15:13:09.652+08
e1b9b28c-8642-45bc-9169-166ccf52321b	Wales national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_wales_national_football_team.jpg	f	english	2016-08-25 15:13:09.653+08
c3ec88be-2c65-40e6-94d3-d882e2a06042	Argentina national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_argentina_national_football_team.jpg	f	english	2016-08-25 15:13:09.654+08
10c1cb4c-936d-47a3-9e92-55ca51b3a6a8	Hungary national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_hungary_national_football_team.jpg	f	english	2016-08-25 15:13:09.656+08
c9419330-a83a-402c-a782-6e4f37c37469	Crystal Palace F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_crystal_palace_f.c..jpg	f	english	2016-08-25 15:13:09.657+08
b46d942e-ea96-4048-a23c-65a6ba71c93a	S.L. Benfica	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_s.l._benfica.jpg	f	english	2016-08-25 15:13:09.658+08
d2935d07-9f5e-4c15-9d6b-67cd61c6de83	Inter Milan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_inter_milan.jpg	f	english	2016-08-25 15:13:09.659+08
d7e8d6fb-daec-4b49-9c6c-23d6c8c0f92f	Swansea City A.F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_swansea_city_a.f.c..jpg	f	english	2016-08-25 15:13:09.66+08
9f1d8b05-1978-4c65-894d-51f365027791	Newcastle United F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_newcastle_united_f.c..jpg	f	english	2016-08-25 15:13:09.661+08
799be316-0595-459b-be2f-ada9f356cdff	Brazil national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_brazil_national_football_team.jpg	f	english	2016-08-25 15:13:09.662+08
a6532267-5e8e-4793-82ad-22f5a18aad8e	Slovakia national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_slovakia_national_football_team.jpg	f	english	2016-08-25 15:13:09.663+08
7cace6c4-a8d5-468f-92d1-b01226dde8bd	Aston Villa F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_aston_villa_f.c..jpg	f	english	2016-08-25 15:13:09.664+08
dc8ff1a1-23cf-4572-abe4-dd4c9a9d1814	A.S. Roma	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_a.s._roma.jpg	f	english	2016-08-25 15:13:09.665+08
fc2d5b12-c018-41cc-aaa5-ec13926c8db6	Russia national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_russia_national_football_team.jpg	f	english	2016-08-25 15:13:10.013+08
9413fe82-efb3-49d1-ad84-49d48c6337ae	FC Dynamo Kyiv	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_fc_dynamo_kyiv.jpg	f	english	2016-08-25 15:13:10.015+08
64d4fc71-d73b-4af7-b623-c17c3e0bd65e	Stoke City F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_stoke_city_f.c..jpg	f	english	2016-08-25 15:13:10.016+08
521e7bcb-9d81-4b9e-acee-c79021a4c41c	Poland national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_poland_national_football_team.jpg	f	english	2016-08-25 15:13:10.017+08
7801511b-7e0a-40d5-b67c-bb18dd249a8e	Southampton F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_southampton_f.c..jpg	f	english	2016-08-25 15:13:10.018+08
8ccff353-83ce-44c8-b14a-43113deaf2cf	S.S.C. Napoli	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_s.s.c._napoli.jpg	f	english	2016-08-25 15:13:10.019+08
48efe3a2-046e-40c9-9929-93b287c9193a	Romania national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_romania_national_football_team.jpg	f	english	2016-08-25 15:13:10.02+08
8ff93631-8aa9-4807-b714-2edaaee2f7c1	Croatia national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_croatia_national_football_team.jpg	f	english	2016-08-25 15:13:10.021+08
94980444-d2f6-4a75-9671-a4f0cb33b1d7	Music	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	english	2016-08-25 15:13:12.837+08
a0fbcd36-3e0f-46e6-979c-0c5730c6bb99	Northern Ireland national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_northern_ireland_national_football_team.jpg	f	english	2016-08-25 15:13:10.022+08
8616b69f-da12-4bc7-a570-a93d969da000	Sunderland A.F.C.	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_sunderland_a.f.c..jpg	f	english	2016-08-25 15:13:10.023+08
62032c20-b706-4918-9d59-11f5c343d1a2	Czech Republic national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_czech_republic_national_football_team.jpg	f	english	2016-08-25 15:13:10.024+08
bd892f14-b424-4475-84f6-d2c5b751b009	Sweden national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_sweden_national_football_team.jpg	f	english	2016-08-25 15:13:10.025+08
5ed2e0cc-a0bd-4a6e-acbe-aaa8feb61d21	FC Shakhtar Donetsk	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_fc_shakhtar_donetsk.jpg	f	english	2016-08-25 15:13:10.026+08
4f9346d1-04a8-4ebc-ba6d-135b9ea45847	PSV Eindhoven	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_psv_eindhoven.jpg	f	english	2016-08-25 15:13:10.027+08
60e93a6d-2f68-4415-892d-4fd57d7ae3be	FC Zenit Saint Petersburg	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_fc_zenit_saint_petersburg.jpg	f	english	2016-08-25 15:13:10.028+08
318a953e-8f68-4f15-902a-6db32ae6f452	France national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_france_national_football_team.jpg	f	english	2016-08-25 15:13:10.028+08
ab21a088-edaf-42ad-b025-f488faa172e5	Ukraine national football team	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	football	https://s3.amazonaws.com/lymchat/pics/football_ukraine_national_football_team.jpg	f	english	2016-08-25 15:13:10.029+08
d48f7347-5baf-4502-a525-6ff06fbca0df	Afghanistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/af.png	f	english	2016-08-25 15:13:10.03+08
87727feb-ce3c-4d22-a110-0816935fb3b0	Aland Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ax.png	f	english	2016-08-25 15:13:10.031+08
d1aecd80-70d1-4bbf-8bf1-bb62e968a346	Albania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/al.png	f	english	2016-08-25 15:13:10.031+08
17657b33-b19d-499c-bcae-3ac6d84cac18	Algeria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/dz.png	f	english	2016-08-25 15:13:10.032+08
3d371de2-baf6-4914-a5fe-1fd36d4814d6	American Samoa	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/as.png	f	english	2016-08-25 15:13:10.033+08
6445c129-27ae-438c-9e95-1987bad36ae2	Andorra	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ad.png	f	english	2016-08-25 15:13:10.034+08
826faa2a-0cd1-4f44-a8e3-3954bce317ea	Angola	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ao.png	f	english	2016-08-25 15:13:10.035+08
79f904d0-e703-401f-a020-e0a8ba55985f	Anguilla	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ai.png	f	english	2016-08-25 15:13:10.035+08
4efcce55-bab2-4b8d-aba9-755cd6710b00	Antigua and Barbuda	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ag.png	f	english	2016-08-25 15:13:10.036+08
22186844-ea8e-4e21-9087-19a8d815ad14	Argentina	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ar.png	f	english	2016-08-25 15:13:10.037+08
4920d2b0-191e-4fa0-a56f-af62f087e695	Armenia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/am.png	f	english	2016-08-25 15:13:10.037+08
b8f699d8-94be-4a14-b8a8-35506b72fa12	Aruba	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/aw.png	f	english	2016-08-25 15:13:10.038+08
2466f16d-f72a-4888-83c4-d8b42933bfae	Australia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/au.png	f	english	2016-08-25 15:13:10.039+08
d32442ff-8649-4bb8-9680-4eb701c44307	Austria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/at.png	f	english	2016-08-25 15:13:10.04+08
5b61bf3f-d45e-46d1-bfb4-55643ee8b3a9	Azerbaijan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/az.png	f	english	2016-08-25 15:13:10.04+08
340de4c7-b969-4d41-8494-d0a3e0804bad	Bahamas	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bs.png	f	english	2016-08-25 15:13:10.041+08
589619ca-68a5-4137-a3b9-03bd85477e46	Bahrain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bh.png	f	english	2016-08-25 15:13:10.042+08
b6123539-7e09-46c3-b464-b29e9bbb9663	Bangladesh	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bd.png	f	english	2016-08-25 15:13:10.043+08
445818df-3360-4c21-8f40-a3ea24e2ec8e	Barbados	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bb.png	f	english	2016-08-25 15:13:10.044+08
7d995195-ad9b-470c-969c-b3960c317b79	Belarus	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/by.png	f	english	2016-08-25 15:13:10.045+08
7803ff6e-05b6-4adc-830e-30e63ce564df	Belgium	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/be.png	f	english	2016-08-25 15:13:10.046+08
8e9430f9-ffb9-4a47-ab30-5aa6f811cc67	Belize	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bz.png	f	english	2016-08-25 15:13:10.047+08
4158130b-ac17-4abb-bde6-2d652078eb8f	Benin	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bj.png	f	english	2016-08-25 15:13:10.048+08
b17a508c-740c-4caa-ab70-c5eca52c092c	Bermuda	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bm.png	f	english	2016-08-25 15:13:10.048+08
4892a43b-e8a1-43a2-b46c-d167b19a2f31	Bhutan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bt.png	f	english	2016-08-25 15:13:10.049+08
e84aed97-6435-49ef-9008-9e28d5e246b2	Bolivia (Plurinational State of)	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bo.png	f	english	2016-08-25 15:13:10.051+08
129526db-c2e8-4210-b98a-fe0447f1bc91	Bonaire, Sint Eustatius and Saba	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bq.png	f	english	2016-08-25 15:13:10.052+08
8d5bec0a-56a6-4728-b490-7a2b87d7d5b7	Bosnia and Herzegovina	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ba.png	f	english	2016-08-25 15:13:10.053+08
db91af66-41e0-417f-8cc5-6b5028c87027	Botswana	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bw.png	f	english	2016-08-25 15:13:10.054+08
70156ecb-9ead-4711-9c83-d09164b715b9	Brazil	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/br.png	f	english	2016-08-25 15:13:10.055+08
5ff8a9af-a9b9-43c6-a76b-265d141bd6f4	British Indian Ocean Territory	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/io.png	f	english	2016-08-25 15:13:10.055+08
6cbf5f9f-9ee5-498e-9aa8-0fc8ad7f6112	Brunei Darussalam	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bn.png	f	english	2016-08-25 15:13:10.056+08
1b923834-769a-4f8f-8303-52005aeef089	Bulgaria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bg.png	f	english	2016-08-25 15:13:10.057+08
62bcf716-b2ca-46f6-83d8-f49f3c99c40b	Burkina Faso	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bf.png	f	english	2016-08-25 15:13:10.415+08
b54d75a5-f779-4825-8621-08028540e22b	Burundi	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bi.png	f	english	2016-08-25 15:13:10.417+08
e0005239-9022-4f97-9014-a30ea3240f3f	Cabo Verde	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cv.png	f	english	2016-08-25 15:13:10.418+08
038a6620-ab04-4f6b-8480-764a49d082a1	Cambodia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/kh.png	f	english	2016-08-25 15:13:10.419+08
a5f1c244-588f-432c-8629-47c2061334cf	Cayman Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ky.png	f	english	2016-08-25 15:13:10.423+08
f0695a09-2ec4-4153-83b4-5ca5bedfe7c2	Central African Republic	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cf.png	f	english	2016-08-25 15:13:10.424+08
cf124fae-6638-4e74-b98c-3dff293e241e	Chad	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/td.png	f	english	2016-08-25 15:13:10.425+08
3ca6b8d8-9b48-4b3e-96c5-92c612f332ca	Chile	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cl.png	f	english	2016-08-25 15:13:10.426+08
d77b2e01-270e-4009-9922-2e9406b88639	China	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cn.png	f	english	2016-08-25 15:13:10.427+08
cd42210e-a01b-4d34-a326-5f3efec15446	Christmas Island	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cx.png	f	english	2016-08-25 15:13:10.428+08
042b2d8a-d931-4456-94ff-1e183ae4bc41	Cocos (Keeling) Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cc.png	f	english	2016-08-25 15:13:10.429+08
4be61071-f7c6-40de-b4b5-3cf09633d536	Colombia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/co.png	f	english	2016-08-25 15:13:10.43+08
5afe1994-4d39-4e86-ac0b-89f49440770f	Comoros	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/km.png	f	english	2016-08-25 15:13:10.431+08
35e9a8dc-95ea-4a7a-aec4-b27f2919a970	Cook Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ck.png	f	english	2016-08-25 15:13:10.432+08
1f9467c7-98f3-4fa7-86fd-6bea224f0a63	Costa Rica	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cr.png	f	english	2016-08-25 15:13:10.433+08
a0e3fc35-d913-4ac7-aa7d-13bfd30c4a0d	Croatia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/hr.png	f	english	2016-08-25 15:13:10.434+08
670d1161-a0c2-4024-a3f3-f9c45bd02975	Cuba	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cu.png	f	english	2016-08-25 15:13:10.435+08
6b206f44-d7ce-4cf3-bf5f-3550a9261b98	Curaçao	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cw.png	f	english	2016-08-25 15:13:10.435+08
b6d0174e-de2d-4cf1-85b7-064a8da4719a	Cyprus	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cy.png	f	english	2016-08-25 15:13:10.436+08
b772e16d-4123-4aa0-820d-a00de874acef	Czech Republic	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cz.png	f	english	2016-08-25 15:13:10.437+08
5a089732-3fc8-4d18-99d4-7c17690c8e6a	Côte d'Ivoire	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ci.png	f	english	2016-08-25 15:13:10.438+08
835de439-e474-482f-8d13-4e060f958a8f	Democratic Republic of the Congo	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cd.png	f	english	2016-08-25 15:13:10.439+08
c076adfc-6d42-40b1-a8cc-1c283dddf972	Denmark	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/dk.png	f	english	2016-08-25 15:13:10.44+08
7c301b1a-ce2f-4de5-aa12-c255fb5bbbac	Djibouti	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/dj.png	f	english	2016-08-25 15:13:10.44+08
18dde616-8c19-4271-a2ec-e1e44a5f0b03	Dominica	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/dm.png	f	english	2016-08-25 15:13:10.441+08
aa83e4f4-df86-4b53-8993-209005d32750	Dominican Republic	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/do.png	f	english	2016-08-25 15:13:10.442+08
396e45de-005d-41b4-aa5f-01d7ca0219c4	Ecuador	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ec.png	f	english	2016-08-25 15:13:10.442+08
ea0dcb51-5090-41e1-9e2e-9957cee460a6	Egypt	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/eg.png	f	english	2016-08-25 15:13:10.443+08
000a9962-007c-4fa3-9bcb-738f6dc0e6fa	El Salvador	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sv.png	f	english	2016-08-25 15:13:10.444+08
0ff1e851-84c3-4525-9774-d0894ecaabc5	Equatorial Guinea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gq.png	f	english	2016-08-25 15:13:10.444+08
488d08b5-7ca6-47a2-9c36-ec04565ab310	Eritrea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/er.png	f	english	2016-08-25 15:13:10.445+08
78160f4a-acce-4a09-9978-8635efbdcc14	Estonia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ee.png	f	english	2016-08-25 15:13:10.446+08
bcb84a1c-4f55-4526-a12e-e37622f7f7dd	Ethiopia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/et.png	f	english	2016-08-25 15:13:10.446+08
75b382c9-4d68-47b2-af90-47d4dbe82688	Falkland Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/fk.png	f	english	2016-08-25 15:13:10.447+08
e934a6ff-3cd4-4b48-809f-db6d09c1d3e2	Faroe Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/fo.png	f	english	2016-08-25 15:13:10.448+08
c9cd3a08-5e2a-4951-ac2b-a7992b08a7aa	Federated States of Micronesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/fm.png	f	english	2016-08-25 15:13:10.449+08
aa86b5bb-939b-4164-adfc-edaaaf4ed648	Fiji	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/fj.png	f	english	2016-08-25 15:13:10.449+08
cc1665d7-9720-4dcf-b176-1436557c1ba2	Finland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/fi.png	f	english	2016-08-25 15:13:10.45+08
a09aa22e-f1a7-4f6c-bf35-a1367cc8e7b7	Former Yugoslav Republic of Macedonia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mk.png	f	english	2016-08-25 15:13:10.45+08
f5ddf2e7-93b2-4f61-81b8-74f8daf4873f	France	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/fr.png	f	english	2016-08-25 15:13:10.451+08
f2c4bb9c-663f-4590-a6bc-0bfc1f085c8d	French Guiana	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gf.png	f	english	2016-08-25 15:13:10.452+08
c1e5a151-21a0-46ab-bcb7-0830681bfdfb	French Polynesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pf.png	f	english	2016-08-25 15:13:10.452+08
ba91bba9-33a0-4844-9e65-dd77a4f6d9e9	French Southern Territories	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tf.png	f	english	2016-08-25 15:13:10.453+08
f64999d7-ce13-40c3-b90a-721a869c0129	Gabon	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ga.png	f	english	2016-08-25 15:13:10.454+08
8a562fd4-3647-469c-a056-3dd993270922	Gambia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gm.png	f	english	2016-08-25 15:13:10.454+08
a034e914-1d5a-48db-a2f2-7c079e75af0d	Georgia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ge.png	f	english	2016-08-25 15:13:10.455+08
2badbad8-895d-4e63-8ffd-2c74670efeea	Germany	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/de.png	f	english	2016-08-25 15:13:10.456+08
430164ce-5297-43f7-a058-64000150be0e	Ghana	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gh.png	f	english	2016-08-25 15:13:10.457+08
ff174a07-4874-41a9-b0b8-858aafb6c31b	Gibraltar	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gi.png	f	english	2016-08-25 15:13:10.81+08
68f6c505-3411-4428-99e6-2751ba899bdc	Greece	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gr.png	f	english	2016-08-25 15:13:10.812+08
4abbd2e6-6cc6-4858-8b26-f3a8a4fe9b62	Greenland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gl.png	f	english	2016-08-25 15:13:10.813+08
b9847263-a4a6-4038-ab36-db61b258e390	Grenada	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gd.png	f	english	2016-08-25 15:13:10.814+08
a63455bc-aa00-45a2-b31d-0dff426f3193	Guadeloupe	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gp.png	f	english	2016-08-25 15:13:10.815+08
d84a1a5d-c966-49b7-95d5-71d1679e683c	Guam	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gu.png	f	english	2016-08-25 15:13:10.816+08
1cd74081-86ac-45d3-a1c8-e88e9408ef2b	Guatemala	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gt.png	f	english	2016-08-25 15:13:10.817+08
9832b7b7-41dd-4546-805f-59ac36692184	Guernsey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gg.png	f	english	2016-08-25 15:13:10.818+08
b89fdc86-9731-4f62-bc49-c4dee6ddbe94	Guinea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gn.png	f	english	2016-08-25 15:13:10.819+08
7afe337f-9175-4f15-b7b0-2b31aa89f7aa	Guinea-Bissau	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gw.png	f	english	2016-08-25 15:13:10.82+08
8b954cf5-4a09-437b-b1a4-4c5df5c302fa	Guyana	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gy.png	f	english	2016-08-25 15:13:10.821+08
fccdaa14-303c-4636-ae74-4fbe83acb581	Haiti	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ht.png	f	english	2016-08-25 15:13:10.822+08
10cd47fa-efa8-4942-af6c-716d4e54051d	Holy See	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/va.png	f	english	2016-08-25 15:13:10.823+08
eca86af3-7b87-472b-993c-e07b703171aa	Honduras	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/hn.png	f	english	2016-08-25 15:13:10.824+08
b67ab3fb-7c36-482d-9b1b-553ba3df1157	Hong Kong	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/hk.png	f	english	2016-08-25 15:13:10.825+08
0ddba658-4545-42b9-8fec-a3a82b257562	Hungary	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/hu.png	f	english	2016-08-25 15:13:10.826+08
b3a03c9a-5535-459a-9ecf-712a72973083	Iceland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/is.png	f	english	2016-08-25 15:13:10.827+08
2577fe45-1b30-4fae-a7c3-a4dd25823181	India	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/in.png	f	english	2016-08-25 15:13:10.828+08
1b2fa85b-5c64-4409-8987-cb882d0c5d65	Indonesia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/id.png	f	english	2016-08-25 15:13:10.829+08
c1ecef25-b368-44a1-a8e2-0b72c8a2c019	Iran (Islamic Republic of)	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ir.png	f	english	2016-08-25 15:13:10.831+08
54bb1dfe-f546-415e-a62a-a7c23440cc7a	Iraq	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/iq.png	f	english	2016-08-25 15:13:10.832+08
7461382d-1121-446b-b68b-9dfe6668bd88	Ireland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ie.png	f	english	2016-08-25 15:13:10.833+08
952ad802-b58d-4352-877a-c8a42be478cc	Isle of Man	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/im.png	f	english	2016-08-25 15:13:10.834+08
e6f260d6-a32d-42ee-91ae-c44e9515d1d2	Israel	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/il.png	f	english	2016-08-25 15:13:10.835+08
da7c7133-53ad-4568-8d70-2434f4cea079	Italy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/it.png	f	english	2016-08-25 15:13:10.836+08
43ec731f-fbbd-4102-ae1f-1088dbace2a7	Jamaica	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/jm.png	f	english	2016-08-25 15:13:10.838+08
a2d8c29e-e781-46fc-a705-afb7d386ab38	Jersey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/je.png	f	english	2016-08-25 15:13:10.84+08
4d380fc9-2d6f-4407-8afa-43ea4f0a6e4e	Jordan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/jo.png	f	english	2016-08-25 15:13:10.841+08
2d324002-3c12-4029-b3e8-4e5340cc408c	Kazakhstan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/kz.png	f	english	2016-08-25 15:13:10.842+08
a0b70847-81c7-470c-b1d2-0cad5934d4aa	Kenya	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ke.png	f	english	2016-08-25 15:13:10.843+08
63a837f1-207c-491c-9ea8-042a3b48272f	Kiribati	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ki.png	f	english	2016-08-25 15:13:10.844+08
41646985-882f-498b-b821-e71f975eff72	Kuwait	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/kw.png	f	english	2016-08-25 15:13:10.845+08
30372b08-aaf8-467a-9426-52cbcc6ce1f6	Kyrgyzstan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/kg.png	f	english	2016-08-25 15:13:10.846+08
a4e1e240-965e-486c-ba8c-e8bed2785736	Laos	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/la.png	f	english	2016-08-25 15:13:10.847+08
b08bdcb4-5bd3-41a6-b054-a7ed15f5f5ae	Latvia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/lv.png	f	english	2016-08-25 15:13:10.848+08
b42d7162-d814-47bc-97d1-10b6428bf2c3	Lebanon	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/lb.png	f	english	2016-08-25 15:13:10.849+08
69e5c652-ca88-4345-93d3-ae7a6b9e6d2b	Lesotho	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ls.png	f	english	2016-08-25 15:13:10.85+08
7f97a5f2-fe37-421d-8e8b-4144bc4c607d	Liberia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/lr.png	f	english	2016-08-25 15:13:10.851+08
69d53b9e-8029-40c9-ab24-2d621c02bac9	Libya	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ly.png	f	english	2016-08-25 15:13:10.852+08
06a460d7-9c59-45ab-9ab1-890c45748ce8	Liechtenstein	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/li.png	f	english	2016-08-25 15:13:10.853+08
0ca1c38c-4ee0-4a5f-970a-ec475abfd023	Lithuania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/lt.png	f	english	2016-08-25 15:13:10.854+08
5071acec-2f59-4618-acb5-60dffaef0720	Luxembourg	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/lu.png	f	english	2016-08-25 15:13:10.855+08
b1b5926a-9d76-449f-bc59-08566cbe4483	Macau	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mo.png	f	english	2016-08-25 15:13:10.856+08
b9a56891-729c-499a-a763-34b2056c71b1	Madagascar	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mg.png	f	english	2016-08-25 15:13:10.857+08
84fd3dd9-0b08-44e8-954a-bbef910c93d9	Malawi	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mw.png	f	english	2016-08-25 15:13:10.858+08
de562567-2802-49b0-9f0c-17a8b083fe06	Malaysia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/my.png	f	english	2016-08-25 15:13:10.859+08
0c4f4e18-1676-4a1e-a3cb-8656d6a12836	Maldives	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mv.png	f	english	2016-08-25 15:13:10.86+08
73385d67-8b79-414d-939e-21e6c5f8de1b	Mali	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ml.png	f	english	2016-08-25 15:13:10.861+08
b5bafc96-6fbf-4c76-8df7-c5fd004b3aaa	Malta	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mt.png	f	english	2016-08-25 15:13:11.213+08
0b946410-4033-4122-9525-127a71e99e56	Marshall Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mh.png	f	english	2016-08-25 15:13:11.216+08
59dcda55-768c-472e-b171-e0196a0c1610	Martinique	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mq.png	f	english	2016-08-25 15:13:11.217+08
0d0a369d-6930-4c5d-bc1a-09a5dbff6070	Mauritania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mr.png	f	english	2016-08-25 15:13:11.218+08
5bf7a6ba-3ddf-4bf8-b4c1-20ef1908b9a6	Mayotte	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/yt.png	f	english	2016-08-25 15:13:11.219+08
33f48102-1e66-448e-bd86-feb1ef7a2129	Mexico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mx.png	f	english	2016-08-25 15:13:11.22+08
593e698f-175a-4333-b2be-fef678b10833	Moldova	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/md.png	f	english	2016-08-25 15:13:11.222+08
fba0d1c1-94f3-48e7-838b-98b7b1c3de86	Monaco	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mc.png	f	english	2016-08-25 15:13:11.222+08
5c89bf2f-faca-4767-8348-c8835e0cb1f5	Mongolia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mn.png	f	english	2016-08-25 15:13:11.223+08
9a2aa545-5261-4255-b127-0c2fee9f2fa3	Montenegro	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/me.png	f	english	2016-08-25 15:13:11.224+08
7b7b8750-8660-4476-b861-c33d37fd21cf	Montserrat	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ms.png	f	english	2016-08-25 15:13:11.225+08
90bcca3b-24d9-4a17-a5a3-20e401f1d68c	Morocco	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ma.png	f	english	2016-08-25 15:13:11.226+08
82fb0d10-b5aa-4297-a827-31e2693c78cc	Mozambique	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mz.png	f	english	2016-08-25 15:13:11.227+08
0ff67505-6595-4ee4-bde0-18fd8a131267	Myanmar	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mm.png	f	english	2016-08-25 15:13:11.227+08
9709530e-58fc-4fdd-ac29-f319fc543e53	Namibia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/na.png	f	english	2016-08-25 15:13:11.228+08
ea7e0964-d66b-4cea-9301-eb4bf29741f7	Nauru	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/nr.png	f	english	2016-08-25 15:13:11.229+08
15752dec-57a3-4394-adb6-98931a8cd655	Nepal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/np.png	f	english	2016-08-25 15:13:11.229+08
62b32a9a-db94-4e1e-a03d-34b61d94be04	Netherlands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/nl.png	f	english	2016-08-25 15:13:11.23+08
6fb7928f-9b2b-410a-8659-517777c41775	New Caledonia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/nc.png	f	english	2016-08-25 15:13:11.231+08
74e816f0-d224-4e31-9960-89a3da2c1886	New Zealand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/nz.png	f	english	2016-08-25 15:13:11.231+08
759d6f47-2d46-4144-9549-ba06658a53c4	Nicaragua	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ni.png	f	english	2016-08-25 15:13:11.232+08
da357b86-5d24-4be5-ba06-c2f0d749a2bc	Niger	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ne.png	f	english	2016-08-25 15:13:11.233+08
5c8d9791-151a-4af5-95b8-d0ccd84cfb26	Nigeria	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ng.png	f	english	2016-08-25 15:13:11.234+08
fb51018a-4aeb-4ec0-86ff-d645a1205a42	Niue	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/nu.png	f	english	2016-08-25 15:13:11.234+08
2872bcc7-28c5-4178-9d82-4760e998a716	Norfolk Island	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/nf.png	f	english	2016-08-25 15:13:11.235+08
9a47f432-8ea8-4efe-9666-fefad04f32c4	North Korea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/kp.png	f	english	2016-08-25 15:13:11.236+08
029b5edf-97e1-49c4-be5f-006f877f5145	Northern Mariana Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mp.png	f	english	2016-08-25 15:13:11.236+08
8f433564-69cc-4f7f-8669-c57ee4c27b0a	Norway	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/no.png	f	english	2016-08-25 15:13:11.237+08
a6d0c2f5-00be-49b1-aeea-5b5983574703	Oman	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/om.png	f	english	2016-08-25 15:13:11.238+08
ca2238dc-d785-43a6-a484-5cc94fa80936	Pakistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pk.png	f	english	2016-08-25 15:13:11.238+08
2dfb4aef-5db2-424d-a4d0-cd17c7e6d035	Palau	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pw.png	f	english	2016-08-25 15:13:11.239+08
1a100211-f0a8-473b-b97b-2be6b36ea2b1	Panama	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pa.png	f	english	2016-08-25 15:13:11.24+08
39695c41-ea09-4f65-9876-429e54ccca26	Papua New Guinea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pg.png	f	english	2016-08-25 15:13:11.24+08
9cef02c2-f404-451e-9df4-7f67dd0f7f96	Paraguay	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/py.png	f	english	2016-08-25 15:13:11.241+08
66f898f3-4b6f-417d-97e3-9cbb9b98fb38	Peru	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pe.png	f	english	2016-08-25 15:13:11.242+08
cb6b5646-3782-4cea-aab4-6c6ab6a94c68	Philippines	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ph.png	f	english	2016-08-25 15:13:11.242+08
2b95aa43-c6a5-4273-ba89-d93b0b9a1de3	Pitcairn	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pn.png	f	english	2016-08-25 15:13:11.243+08
7bae4b99-7044-4796-8085-cdec28b50347	Poland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pl.png	f	english	2016-08-25 15:13:11.244+08
0955d216-24d7-4a11-aa22-8b187a19577c	Portugal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pt.png	f	english	2016-08-25 15:13:11.244+08
f2f492a0-67e2-4cd7-91ad-6faaf03610a3	Puerto Rico	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pr.png	f	english	2016-08-25 15:13:11.245+08
faafcc3c-06cf-41f3-8c78-95b5de4e2e0e	Qatar	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/qa.png	f	english	2016-08-25 15:13:11.246+08
f88b550a-5499-48af-b097-2293d55ea93f	Republic of the Congo	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/cg.png	f	english	2016-08-25 15:13:11.246+08
4c0e16c5-ea9a-4507-a78e-81d319e49e80	Romania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ro.png	f	english	2016-08-25 15:13:11.247+08
917c7c07-3014-4f0d-b958-bab2b34ebcfe	Russia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ru.png	f	english	2016-08-25 15:13:11.248+08
d355209d-7531-4c93-a9e5-b8fa3c361308	Rwanda	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/rw.png	f	english	2016-08-25 15:13:11.248+08
4f9fee4e-e767-459a-8c1b-e92ba5d0324d	Réunion	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/re.png	f	english	2016-08-25 15:13:11.249+08
0cc81f7c-7bfc-4767-83a6-825f86f5759b	Saint Barthélemy	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/bl.png	f	english	2016-08-25 15:13:11.25+08
833b3620-61f1-48a5-a114-9e7e264ca25d	Saint Helena, Ascension and Tristan da Cunha	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sh.png	f	english	2016-08-25 15:13:11.25+08
795f1a61-42e5-4e71-b7a5-69b5f18bbb1b	Saint Kitts and Nevis	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/kn.png	f	english	2016-08-25 15:13:11.251+08
582113c3-7a11-4d0a-b153-cc50b3ce6c72	Saint Lucia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/lc.png	f	english	2016-08-25 15:13:11.611+08
2a829344-d37a-4c3d-a3ae-bd1c79366f90	Saint Martin	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/mf.png	f	english	2016-08-25 15:13:11.612+08
0f58a066-0125-44ff-a99d-840f16b5d842	Saint Pierre and Miquelon	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/pm.png	f	english	2016-08-25 15:13:11.613+08
37caa1e8-64d3-46fe-aa6a-c1761cd07855	Saint Vincent and the Grenadines	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/vc.png	f	english	2016-08-25 15:13:11.614+08
4cb7cfe7-e715-4dca-a4e1-236462a3a38b	Samoa	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ws.png	f	english	2016-08-25 15:13:11.615+08
9c23051b-babf-439b-a401-cea95255da95	San Marino	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sm.png	f	english	2016-08-25 15:13:11.616+08
d95867f1-768b-4be0-b46e-8eb51ce0602b	Sao Tome and Principe	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/st.png	f	english	2016-08-25 15:13:11.617+08
98ca2415-4441-4a39-9306-36440a5032be	Saudi Arabia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sa.png	f	english	2016-08-25 15:13:11.618+08
e903b353-fbbc-4bbf-9483-2c50fbbb2053	Senegal	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sn.png	f	english	2016-08-25 15:13:11.619+08
8df6ce1d-2be7-478b-8a81-1cbfa2d841bd	Serbia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/rs.png	f	english	2016-08-25 15:13:11.62+08
dc768f6d-a3c1-457c-ad18-75565f120ff7	Seychelles	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sc.png	f	english	2016-08-25 15:13:11.621+08
588fba44-1ca5-4e9e-905d-1cff5b082019	Sierra Leone	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sl.png	f	english	2016-08-25 15:13:11.622+08
155643ab-73fe-48e1-a0c6-823f84351d6d	Singapore	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sg.png	f	english	2016-08-25 15:13:11.623+08
d5f7428b-3613-40bb-9c6f-819f0e6b7aa5	Sint Maarten	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sx.png	f	english	2016-08-25 15:13:11.624+08
f9c7d854-2292-4f0c-9108-15507cf09f76	Slovakia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sk.png	f	english	2016-08-25 15:13:11.625+08
74931aa2-c594-4689-aa77-28500fda8660	Slovenia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/si.png	f	english	2016-08-25 15:13:11.625+08
199bbb1e-d907-4f35-b02d-e2eb7304e40a	Solomon Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sb.png	f	english	2016-08-25 15:13:11.626+08
2361f497-bb32-42a1-84ad-b8b078c21422	Somalia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/so.png	f	english	2016-08-25 15:13:11.627+08
0e4981b0-2d2a-4946-ba0d-2229484d3338	South Africa	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/za.png	f	english	2016-08-25 15:13:11.628+08
8717ad10-45dd-401f-aac8-4fa1b2316ee9	South Georgia and the South Sandwich Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gs.png	f	english	2016-08-25 15:13:11.628+08
7028d26e-384a-4326-8b8d-a855814b24d1	South Korea	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/kr.png	f	english	2016-08-25 15:13:11.629+08
8d43b611-8517-4816-9111-2c594f9451b2	South Sudan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ss.png	f	english	2016-08-25 15:13:11.63+08
df97a89b-5259-4919-a4a4-1fe8a58e58b0	Spain	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/es.png	f	english	2016-08-25 15:13:11.631+08
6b1cf348-c80c-422a-b60e-cdd35aae942a	Sri Lanka	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/lk.png	f	english	2016-08-25 15:13:11.632+08
67becd9f-6915-4b9b-aa93-e547ad5607d7	State of Palestine	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ps.png	f	english	2016-08-25 15:13:11.633+08
d645f1db-035a-4008-8c44-45668f307da9	Sudan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sd.png	f	english	2016-08-25 15:13:11.633+08
c3a76ab3-7a28-427b-a0ae-545b64fe9cd4	Suriname	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sr.png	f	english	2016-08-25 15:13:11.634+08
10d81bf5-53a4-4dc2-861c-8919945153c5	Svalbard and Jan Mayen	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sj.png	f	english	2016-08-25 15:13:11.635+08
0584fecb-016b-4205-b3c7-39770d287aee	Swaziland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sz.png	f	english	2016-08-25 15:13:11.635+08
385bf2e8-2a70-428a-9e05-2d1c06628eab	Sweden	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/se.png	f	english	2016-08-25 15:13:11.636+08
a4b5a037-fc8e-4962-9bc0-0fcb07859290	Switzerland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ch.png	f	english	2016-08-25 15:13:11.637+08
94c7aa51-bdc2-416a-a369-b1223f976199	Syrian Arab Republic	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/sy.png	f	english	2016-08-25 15:13:11.638+08
6ee7d8e5-06cb-4be5-8b8c-51fb22adaef9	Taiwan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tw.png	f	english	2016-08-25 15:13:11.638+08
1b887584-15e1-46c9-93cf-959696b13a3b	Tajikistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tj.png	f	english	2016-08-25 15:13:11.639+08
0b022f45-560a-48ca-9056-fd076383ca14	Tanzania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tz.png	f	english	2016-08-25 15:13:11.64+08
c25ad444-04f9-4c3e-85c9-1961eba531b6	Thailand	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/th.png	f	english	2016-08-25 15:13:11.64+08
66a82929-719a-46eb-bd74-fea944ea8c6d	Timor-Leste	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tl.png	f	english	2016-08-25 15:13:11.641+08
3f4eefd1-094e-4e1d-a18f-78e94e0dea53	Togo	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tg.png	f	english	2016-08-25 15:13:11.642+08
a1b77ff2-126b-4d38-8988-47bfb23df7bd	Tokelau	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tk.png	f	english	2016-08-25 15:13:11.643+08
b83ef6c8-2de7-4352-be56-620054ec38ce	Tonga	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/to.png	f	english	2016-08-25 15:13:11.644+08
c359c74b-5127-4d67-aaf9-e8e2b810d28c	Trinidad and Tobago	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tt.png	f	english	2016-08-25 15:13:11.645+08
9cdcb877-3b2a-469c-834b-d3acf1b06f1e	Tunisia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tn.png	f	english	2016-08-25 15:13:11.646+08
f8cbb9b6-2e9e-47b3-b2e6-c69c2acef488	Turkey	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tr.png	f	english	2016-08-25 15:13:11.647+08
b375cb40-f387-43d4-b8d9-011fffacc22b	Turkmenistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tm.png	f	english	2016-08-25 15:13:11.648+08
68d41d98-d9e4-4f27-ba47-b55c8d8f8529	Turks and Caicos Islands	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tc.png	f	english	2016-08-25 15:13:11.649+08
599fbd70-7cbb-4d50-a0a0-a8cd2b68f9c8	Tuvalu	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/tv.png	f	english	2016-08-25 15:13:11.65+08
893318fb-d594-41b3-b0a8-0f307d98a72c	Uganda	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ug.png	f	english	2016-08-25 15:13:11.651+08
385c1c63-ea90-4d04-9236-b968744f0f7b	Ukraine	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ua.png	f	english	2016-08-25 15:13:11.652+08
8e2f8af9-e818-4b5b-b433-0729ef0e1911	United Arab Emirates	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ae.png	f	english	2016-08-25 15:13:11.653+08
285fe1a5-65b9-461f-96a6-88ac806a4613	United Kingdom	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/gb.png	f	english	2016-08-25 15:13:12.013+08
5459b290-0c58-4ad2-b7ff-3e2cfb2c2a39	Uruguay	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/uy.png	f	english	2016-08-25 15:13:12.016+08
587f1457-1887-49d4-8337-17643190a66d	Uzbekistan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/uz.png	f	english	2016-08-25 15:13:12.017+08
2518a6cd-cf47-438c-bb26-153ef2d4fe19	Vanuatu	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/vu.png	f	english	2016-08-25 15:13:12.018+08
61c5e06c-2e23-491d-ba54-db01c8c51b79	Venezuela (Bolivarian Republic of)	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ve.png	f	english	2016-08-25 15:13:12.019+08
617ae0f4-b26c-4824-9f3e-1d249a3e5964	Vietnam	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/vn.png	f	english	2016-08-25 15:13:12.02+08
62b6cce0-2d7b-4ff0-8546-670b0b426188	Virgin Islands (British)	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/vg.png	f	english	2016-08-25 15:13:12.022+08
9a472b0d-52d1-4063-af2b-3bc5e5b91b5d	Virgin Islands (U.S.)	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/vi.png	f	english	2016-08-25 15:13:12.023+08
46fccf0c-c78f-407f-a54d-5b2a43b2c6e0	Wallis and Futuna	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/wf.png	f	english	2016-08-25 15:13:12.025+08
db5e2ac3-d4b2-41fa-a710-76d96448a052	Western Sahara	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/eh.png	f	english	2016-08-25 15:13:12.026+08
db25fe5f-ae13-418e-9d92-e676a3843e2c	Yemen	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/ye.png	f	english	2016-08-25 15:13:12.027+08
da9a2ae7-6e9c-46be-8bc4-d79e6cd203f2	Zambia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/zm.png	f	english	2016-08-25 15:13:12.028+08
5480ed31-5b10-449a-9584-395857064b8b	Zimbabwe	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	country	https://s3.amazonaws.com/lymchat/pics/countries/zw.png	f	english	2016-08-25 15:13:12.029+08
d88886de-1593-4ca3-9048-b7abf5eeed71	Harvard University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_harvard_university.jpg	f	english	2016-08-25 15:13:12.031+08
96b1e82f-6404-42dc-8411-d7246dc1576a	Stanford University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_stanford_university.jpg	f	english	2016-08-25 15:13:12.032+08
ea9de86b-d6c8-4a98-9c22-9d804a100cf6	University of California, Los Angeles	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_california,_los_angeles.jpg	f	english	2016-08-25 15:13:12.034+08
59dc997e-8524-4d21-8400-53a113a2a3bf	Cornell University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_cornell_university.jpg	f	english	2016-08-25 15:13:12.035+08
152239d5-fd79-413e-8a63-ee66f2326a2a	University of California, Berkeley	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_california,_berkeley.jpg	f	english	2016-08-25 15:13:12.036+08
dfd7d77a-433c-4f33-9c09-8ea95e77c289	Princeton University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_princeton_university.jpg	f	english	2016-08-25 15:13:12.037+08
272d92dd-6450-4023-ae45-0d7a4e33c6c9	University of Michigan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_michigan.jpg	f	english	2016-08-25 15:13:12.038+08
20215fd2-6700-41d4-addc-b35e7a06c427	California Institute of Technology	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_california_institute_of_technology.jpg	f	english	2016-08-25 15:13:12.039+08
46c4a1d7-c786-49cf-8d7e-b145c24e7d18	University of Oxford	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_oxford.jpg	f	english	2016-08-25 15:13:12.039+08
6b34da9d-bcb6-438e-b873-ff1cc61e7f37	University of Pennsylvania	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_pennsylvania.jpg	f	english	2016-08-25 15:13:12.04+08
3b0e9dc9-25b6-4448-9b55-928ba5fc80a6	Yale University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_yale_university.jpg	f	english	2016-08-25 15:13:12.041+08
d7eb5c2a-6ba2-4103-bd49-eac400bbd841	University of Cambridge	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_cambridge.jpg	f	english	2016-08-25 15:13:12.042+08
6664e37a-e3d2-4774-ad15-3fe808a2d21c	Duke University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_duke_university.jpg	f	english	2016-08-25 15:13:12.042+08
5eb77ef8-851f-40f1-8261-9e250880f966	University of Chicago	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_chicago.jpg	f	english	2016-08-25 15:13:12.043+08
f4d3d2e1-7063-460e-a446-31f1d8461c9f	Johns Hopkins University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_johns_hopkins_university.jpg	f	english	2016-08-25 15:13:12.043+08
a22cc5ee-4287-4ed4-b1a6-27f1036e3007	Northwestern University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_northwestern_university.jpg	f	english	2016-08-25 15:13:12.044+08
28a50e16-00ee-45b0-aaa2-94ac1afb10de	University of Toronto	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_toronto.jpg	f	english	2016-08-25 15:13:12.045+08
e2aaf380-07d7-440b-a6dc-95c0f45a1a43	National University of Singapore	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_national_university_of_singapore.jpg	f	english	2016-08-25 15:13:12.045+08
dedc5963-8644-409f-9b3f-45fbd95e2a57	Carnegie Mellon University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_carnegie_mellon_university.jpg	f	english	2016-08-25 15:13:12.046+08
447f131b-7b9f-48fe-ad38-72b1fd6b5309	University of Illinois at Urbana–Champaign	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_illinois_at_urbana–champaign.jpg	f	english	2016-08-25 15:13:12.047+08
ad198e4a-ffa5-4c05-9c13-cc245a1f78a8	ETH Zurich	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_eth_zurich.jpg	f	english	2016-08-25 15:13:12.048+08
e9e14618-aaca-4155-a8a6-ae5b4f9c8ec6	University College London	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_college_london.jpg	f	english	2016-08-25 15:13:12.048+08
27997217-4a4f-40e3-a905-f97d40b89c6d	University of Wisconsin-Madison	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_wisconsin-madison.jpg	f	english	2016-08-25 15:13:12.049+08
6e6196fd-5f13-45d9-b2d8-4a404d77fa17	University of Washington	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_washington.jpg	f	english	2016-08-25 15:13:12.049+08
00ba22da-60ed-4b65-acb4-d6fe03373629	New York University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_new_york_university.jpg	f	english	2016-08-25 15:13:12.05+08
cb933362-acc6-47d5-871a-7723f90b92eb	Georgia Institute of Technology	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_georgia_institute_of_technology.jpg	f	english	2016-08-25 15:13:12.051+08
11e309f6-3581-43ac-827d-56b6b9a48c70	University of California, San Diego	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_california,_san_diego.jpg	f	english	2016-08-25 15:13:12.051+08
a3883618-a82c-41f3-b2c4-93d5756a35bc	Book	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	english	2016-08-25 15:13:12.838+08
3ed88405-f007-40ae-abbb-99f8037c4d3e	Columbia University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_columbia_university.jpg	f	english	2016-08-25 15:13:12.033+08
e52e70bd-e876-4fb2-a084-0f68cf13643b	University of Tokyo	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_tokyo.jpg	f	english	2016-08-25 15:13:12.052+08
21d154ba-7319-4496-b5ee-5d9f50f73b96	University of Melbourne	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_melbourne.jpg	f	english	2016-08-25 15:13:12.053+08
c6829c7a-cb9b-46e1-8f10-efc459e703f3	Purdue University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_purdue_university.jpg	f	english	2016-08-25 15:13:12.053+08
04a4c686-5ca6-456a-9e80-0122296319b6	Nanyang Technological University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_nanyang_technological_university.jpg	f	english	2016-08-25 15:13:12.055+08
87b8df87-a4cd-471a-be86-cf220a091709	University of North Carolina at Chapel Hill	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_north_carolina_at_chapel_hill.jpg	f	english	2016-08-25 15:13:12.056+08
064bda4c-c083-4f63-906d-5cd1953ff421	Washington University in St. Louis	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_washington_university_in_st._louis.jpg	f	english	2016-08-25 15:13:12.057+08
5c87925d-942e-4586-869a-c11c00715df8	Imperial College London	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_imperial_college_london.jpg	f	english	2016-08-25 15:13:12.057+08
1682517e-a260-41f4-9814-72e3e2daff32	University of Edinburgh	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_edinburgh.jpg	f	english	2016-08-25 15:13:12.415+08
ceb0ba81-aa9f-4c9f-baa8-4b1345298c8e	Brown University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_brown_university.jpg	f	english	2016-08-25 15:13:12.417+08
8acfb59b-e1f7-4e2c-bd04-ac4083d12dbe	University of British Columbia	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_british_columbia.jpg	f	english	2016-08-25 15:13:12.418+08
a94cc01c-5ea4-4376-9069-e230d7bc9ce0	Texas A&M University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_texas_a&m_university.jpg	f	english	2016-08-25 15:13:12.419+08
669a4f26-cde0-48bb-937b-fd2f33cf8890	University of Texas at Austin	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_texas_at_austin.jpg	f	english	2016-08-25 15:13:12.42+08
b2d60a42-48c9-49d5-a377-c4371b3e4584	University of Minnesota	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_minnesota.jpg	f	english	2016-08-25 15:13:12.421+08
d70a091b-852c-4405-bce5-ce510538cb7e	Ohio State University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_ohio_state_university.jpg	f	english	2016-08-25 15:13:12.422+08
28757f35-650d-46b8-a5c3-d34a8d24893c	Seoul National University	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_seoul_national_university.jpg	f	english	2016-08-25 15:13:12.423+08
44976757-2038-4447-b4a8-9821ced5bcb3	University of Southern California	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_southern_california.jpg	f	english	2016-08-25 15:13:12.425+08
2e8f2e01-0dd3-4dcd-bd1f-34bd536f5034	University of Queensland	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_queensland.jpg	f	english	2016-08-25 15:13:12.426+08
af48161b-592d-4532-aa49-660a32790f11	École Polytechnique Fédérale de Lausanne	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_école_polytechnique_fédérale_de_lausanne.jpg	f	english	2016-08-25 15:13:12.427+08
98367e3b-dd0f-4a52-8674-9fa92ba6b167	University of New South Wales	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_new_south_wales.jpg	f	english	2016-08-25 15:13:12.428+08
1cbd0d4f-ac54-45ee-af26-91e16f7ebc98	Hong Kong University of Science and Technology	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_hong_kong_university_of_science_and_technology.jpg	f	english	2016-08-25 15:13:12.429+08
76d67daf-4e8f-4132-b38c-1df64a8c9eba	University of California, Davis	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_university_of_california,_davis.jpg	f	english	2016-08-25 15:13:12.429+08
13a65e9e-1ac4-4243-801e-ebba2725ed9c	Food	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	english	2016-08-25 15:13:12.831+08
58bc5ac6-b2e6-4db4-8152-60eaf29689f2	Clothes	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	english	2016-08-25 15:13:12.832+08
54f6391e-1bbc-49cc-8d9c-cfaf3d948dd4	Photography	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	english	2016-08-25 15:13:12.833+08
0afaa0e0-9b27-4ce7-aab1-b042b32fd3fa	Architecture	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	english	2016-08-25 15:13:12.834+08
23db7a31-ef6a-4a99-a1b6-f9adeaa7a96d	Art	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	english	2016-08-25 15:13:12.835+08
1bd4cd2a-7b7a-400a-ac86-588e13ba0779	建筑	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	chinese	2016-08-25 15:13:12.85+08
cf61d8c1-1fbc-4505-8920-819412fbb70c	艺术	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	chinese	2016-08-25 15:13:12.852+08
8045a835-dfde-4a54-9cfc-e52025ee6daf	电影	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	chinese	2016-08-25 15:13:12.853+08
9e8514e0-c2a0-48e8-9c34-707a0cfa5c80	音乐	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	chinese	2016-08-25 15:13:12.854+08
cdda5a34-d561-4fec-a7e3-16532514df00	书	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	chinese	2016-08-25 15:13:12.855+08
38c5d415-3c2e-4210-9558-4b647db54605	茶	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	chinese	2016-08-25 15:13:12.857+08
77285942-1dcf-4b49-bf9a-ddd87b73c7a0	衣服	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	\N	\N	f	chinese	2016-08-25 15:13:12.859+08
3a08e7da-da3b-4e52-a406-33cbe4532ada	United States	10000000-3c59-4887-995b-cf275db86343	f	f	\N	1	country	https://s3.amazonaws.com/lymchat/pics/countries/us.png	f	english	2016-08-25 15:13:12.015+08
1e26b24a-365a-49bb-825e-5d323487bba0	Massachusetts Institute of Technology	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	college	https://s3.amazonaws.com/lymchat/pics/college_massachusetts_institute_of_technology.jpg	f	english	2016-08-25 15:13:12.03+08
cd0abb99-fb50-4450-8b88-240212330dec	English	10000000-3c59-4887-995b-cf275db86343	f	f	\N	1	language	\N	f	english	2016-08-25 15:13:07.048+08
0a685c54-2bcc-46cb-81d4-064e8672ca4c	Japan	10000000-3c59-4887-995b-cf275db86343	f	f	\N	1	country	https://s3.amazonaws.com/lymchat/pics/countries/jp.png	f	english	2016-08-25 15:13:10.839+08
b65e3f37-d2c0-4606-aa4c-1443f7d11b2e	San Antonio Spurs	10000000-3c59-4887-995b-cf275db86343	f	f	\N	1	nba	https://s3.amazonaws.com/lymchat/pics/college_san_antonio_spurs.jpg	f	english	2016-08-25 15:13:09.263+08
2c00f31c-9d5b-4ecb-949f-a5ef69163e13	FC Barcelona	10000000-3c59-4887-995b-cf275db86343	f	f	\N	2	football	https://s3.amazonaws.com/lymchat/pics/football_fc_barcelona.jpg	f	english	2016-08-25 15:13:09.639+08
2767c18f-6e80-4380-82a9-d80b2c468cab	北京大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京大学.jpg	f	english	2016-08-25 16:55:40.021+08
b185e985-c2c9-4af2-bf6e-422692e30fc6	清华大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_清华大学.jpg	f	english	2016-08-25 16:55:40.036+08
b645dc98-7f0e-4e62-9e40-aa959d4fb137	复旦大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_复旦大学.jpg	f	english	2016-08-25 16:55:40.043+08
335e7f5c-bdc5-4bb0-b860-75a3df109e49	武汉大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_武汉大学.jpg	f	english	2016-08-25 16:55:40.045+08
79b88f1c-5dd5-432a-b2c9-be8020d2413d	浙江大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_浙江大学.jpg	f	english	2016-08-25 16:55:40.046+08
4f983432-bc49-43a4-87e3-f2c4dc06261f	中国人民大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中国人民大学.jpg	f	english	2016-08-25 16:55:40.051+08
6f59f609-271d-4914-98e7-0fc68785eb07	上海交通大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_上海交通大学.jpg	f	english	2016-08-25 16:55:40.053+08
6e1f85b2-3b82-4c32-aaef-f7182891a474	南京大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_南京大学.jpg	f	english	2016-08-25 16:55:40.054+08
05acaca3-dc0d-4c3a-a9e6-e71bd4131875	国防科学技术大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_国防科学技术大学.jpg	f	english	2016-08-25 16:55:40.055+08
fab902f1-eb3b-470a-91b0-9be5ed3025ce	中山大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中山大学.jpg	f	english	2016-08-25 16:55:40.056+08
8874d8a3-7f8d-4b0b-84b3-0f4abc11d318	吉林大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_吉林大学.jpg	f	english	2016-08-25 16:55:40.058+08
c594772d-d869-4e50-bc0d-b879ede574ce	中国科学技术大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中国科学技术大学.jpg	f	english	2016-08-25 16:55:40.059+08
61489fcc-3b26-4218-99e0-625628b2c5aa	华中科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_华中科技大学.jpg	f	english	2016-08-25 16:55:40.06+08
3273303b-d8a8-4a54-9f54-417d1dfbdb4c	四川大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_四川大学.jpg	f	english	2016-08-25 16:55:40.062+08
e1de6e03-df5b-4b12-9b68-58c062138f9a	北京师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京师范大学.jpg	f	english	2016-08-25 16:55:40.063+08
5366987f-dc2b-41c8-8570-cfa305fa7c13	南开大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_南开大学.jpg	f	english	2016-08-25 16:55:40.065+08
7fef423b-3e32-4692-ac8f-6cd8d2ed0ef7	西安交通大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_西安交通大学.jpg	f	english	2016-08-25 16:55:40.066+08
8fc1c20b-1362-4d45-aa0a-e36ebbb8be42	中南大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中南大学.jpg	f	english	2016-08-25 16:55:40.068+08
afcf4cb2-eb46-4ab8-b9cb-c397cb91ec25	同济大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_同济大学.jpg	f	english	2016-08-25 16:55:40.069+08
57965a57-1521-4960-ae61-493f6ea451ae	天津大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_天津大学.jpg	f	english	2016-08-25 16:55:40.071+08
1d476117-e144-45f5-a75c-1d13e180464e	哈尔滨工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_哈尔滨工业大学.jpg	f	english	2016-08-25 16:55:40.072+08
7f709a96-1b68-4eae-b64f-68f8c78011ae	山东大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_山东大学.jpg	f	english	2016-08-25 16:55:40.073+08
ede8f0b8-8f7e-4b14-aea0-aa698f71637c	厦门大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_厦门大学.jpg	f	english	2016-08-25 16:55:40.074+08
7a3dd17f-4dd3-4939-86cc-d89133c5dfac	东南大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_东南大学.jpg	f	english	2016-08-25 16:55:40.075+08
8718b8e5-82b1-486d-ac3c-0ec5e0b669c0	北京航空航天大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京航空航天大学.jpg	f	english	2016-08-25 16:55:40.076+08
c3046457-f4da-41e9-bee7-1fa3eed5b6fc	东北大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_东北大学.jpg	f	english	2016-08-25 16:55:40.078+08
51a43f29-b1ee-470e-8db4-45f59825f811	重庆大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_重庆大学.jpg	f	english	2016-08-25 16:55:40.079+08
3e93d3d4-dd3c-4be6-b8dd-19a7631e5923	华东师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_华东师范大学.jpg	f	english	2016-08-25 16:55:40.08+08
6370e17c-5c0d-4c8e-8c8c-f9b50451822e	大连理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_大连理工大学.jpg	f	english	2016-08-25 16:55:40.081+08
b75b2863-9e37-460d-8845-fdfbc9630a89	北京理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京理工大学.jpg	f	english	2016-08-25 16:55:40.082+08
a4cf99c2-8038-4dc3-a962-99e21101acd2	华南理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_华南理工大学.jpg	f	english	2016-08-25 16:55:40.083+08
207ab5bf-9996-486c-8550-35ec32025701	中国农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中国农业大学.jpg	f	english	2016-08-25 16:55:40.086+08
5af83206-c4dd-4558-a20f-f83efb89469e	湖南大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_湖南大学.jpg	f	english	2016-08-25 16:55:40.088+08
01abc30d-90f9-4b58-8caf-c4ff44da6edb	华中师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_华中师范大学.jpg	f	english	2016-08-25 16:55:40.089+08
3e129fb7-306c-4e0a-b576-d3ea77570dff	西北工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_西北工业大学.jpg	f	english	2016-08-25 16:55:40.09+08
89e859c3-cd65-44be-be21-20b8eca3f091	兰州大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_兰州大学.jpg	f	english	2016-08-25 16:55:40.091+08
1bfddd86-78f7-434b-aa29-1ee02ef0070a	电子科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_电子科技大学.jpg	f	english	2016-08-25 16:55:40.092+08
abc7a4b5-e641-4d9a-b22e-ca3a5bbaf323	武汉理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_武汉理工大学.jpg	f	english	2016-08-25 16:55:40.093+08
57cffa13-2fbd-46b4-a7fa-a5247cf6f89a	中国地质大学（武汉）	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中国地质大学（武汉）.jpg	f	english	2016-08-25 16:55:40.094+08
6be25ed3-ff0a-4433-b152-575b9658a506	东北师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_东北师范大学.jpg	f	english	2016-08-25 16:55:40.095+08
87b64c4c-a628-4bdd-bc55-8cc1c08c947d	北京科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京科技大学.jpg	f	english	2016-08-25 16:55:40.096+08
9ab41694-3f52-4203-a1e7-ee621c844e5b	中国矿业大学（徐州）	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中国矿业大学（徐州）.jpg	f	english	2016-08-25 16:55:40.097+08
01623481-5007-4155-b5dd-701155a6b4e4	北京交通大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京交通大学.jpg	f	english	2016-08-25 16:55:40.098+08
0253ef8a-ccea-4cef-8728-7b5aea21ef77	长安大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_长安大学.jpg	f	english	2016-08-25 16:55:40.279+08
15444906-a6ba-4a11-9851-605b89135706	北京协和医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京协和医学院.jpg	f	english	2016-08-25 16:55:40.28+08
138755d9-1ccd-43f2-8097-a0ff666f5313	南京农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_南京农业大学.jpg	f	english	2016-08-25 16:55:40.281+08
0aba6272-4ecd-48aa-8ef3-79a3d9b60570	西北大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_西北大学.jpg	f	english	2016-08-25 16:55:40.282+08
785d356a-1ac1-40d5-a935-9b09d88fe299	华东理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_华东理工大学.jpg	f	english	2016-08-25 16:55:40.283+08
9e3cd7b9-0957-42ce-88e7-620b08225d30	华中农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_华中农业大学.jpg	f	english	2016-08-25 16:55:40.284+08
06cfd27f-14bb-45f5-8ee0-e5932fba5ba8	南京师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_南京师范大学.jpg	f	english	2016-08-25 16:55:40.285+08
665bd160-1586-4d1d-abb1-b6204ab85cca	西南交通大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_西南交通大学.jpg	f	english	2016-08-25 16:55:40.286+08
7e3e71f7-97c1-4429-95a7-c5e62f862c09	西南大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_西南大学.jpg	f	english	2016-08-25 16:55:40.287+08
b2dbaa9a-b2f9-4c94-8d95-336e121410cb	中国海洋大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中国海洋大学.jpg	f	english	2016-08-25 16:55:40.288+08
647709c6-e445-463d-86d9-031c44abc3ab	河海大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_河海大学.jpg	f	english	2016-08-25 16:55:40.289+08
f1839928-224b-4cb7-ab4a-680d8c7ad33d	解放军信息工程大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_解放军信息工程大学.jpg	f	english	2016-08-25 16:55:40.29+08
f4e15a38-cf4f-4a75-b767-20b4c744a0ac	南京理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_南京理工大学.jpg	f	english	2016-08-25 16:55:40.291+08
d2ff2e71-02b1-43e5-82cc-4b194b7615b4	哈尔滨工程大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_哈尔滨工程大学.jpg	f	english	2016-08-25 16:55:40.292+08
294f36ac-2ab9-4043-901e-7c57e01687db	暨南大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_暨南大学.jpg	f	english	2016-08-25 16:55:40.293+08
86aea3bf-d072-48f6-8c46-0a58e71c62a6	云南大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_云南大学.jpg	f	english	2016-08-25 16:55:40.294+08
0fa84893-811b-4921-ba02-e0fda3e88589	中国石油大学（华东）	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中国石油大学（华东）.jpg	f	english	2016-08-25 16:55:40.295+08
ac017d6f-8003-4a65-97f5-fd859e35736c	南京航空航天大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_南京航空航天大学.jpg	f	english	2016-08-25 16:55:40.296+08
9ae39e65-c9b6-4cd3-bf56-1b27eea8ae73	郑州大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_郑州大学.jpg	f	english	2016-08-25 16:55:40.297+08
e0c226a8-b990-4fef-9404-1bcdf4d01ec5	苏州大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_苏州大学.jpg	f	english	2016-08-25 16:55:40.298+08
27c07cc4-304c-49d0-a4cb-bd4f5abe51f1	上海财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_上海财经大学.jpg	f	english	2016-08-25 16:55:40.299+08
cbeb014d-7f12-45b6-bd72-3044c3cc03e4	西北农林科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_西北农林科技大学.jpg	f	english	2016-08-25 16:55:40.3+08
80b0b6ec-e8db-4916-be1f-7ae98ac2893f	中国政法大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中国政法大学.jpg	f	english	2016-08-25 16:55:40.301+08
1d227dd4-463d-42c0-9e38-67a7e8e52247	合肥工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_合肥工业大学.jpg	f	english	2016-08-25 16:55:40.303+08
5006af86-7e2e-4cfb-9baf-d582fe3ecb79	北京邮电大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京邮电大学.jpg	f	english	2016-08-25 16:55:40.304+08
726928b2-c1c6-4f6b-936a-1c9113b9c4da	西安电子科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_西安电子科技大学.jpg	f	english	2016-08-25 16:55:40.305+08
0e963f2d-2081-46bb-aba4-cfe5bdcfae21	解放军第三军医大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.306+08
7d287741-eeb9-422c-a269-b3c08d109df6	解放军第二军医大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_解放军第二军医大学.jpg	f	english	2016-08-25 16:55:40.307+08
d3928beb-f903-4154-a586-576916d61d3d	湖南师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_湖南师范大学.jpg	f	english	2016-08-25 16:55:40.311+08
07a4b8d9-a50c-4a6d-a323-e0b42dd0ae0e	解放军第四军医大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.312+08
176ed456-f7a6-4b69-b19c-651d9a34e0a8	华南师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_华南师范大学.jpg	f	english	2016-08-25 16:55:40.313+08
0797eb6e-9b6e-4acf-a230-07bd580dce07	上海大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_上海大学.jpg	f	english	2016-08-25 16:55:40.315+08
8563856e-9d20-491e-97c6-eab1ee3f1e10	中南财经政法大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中南财经政法大学.jpg	f	english	2016-08-25 16:55:40.316+08
c8f6f2f0-e839-4305-9136-a09c176130a7	西南财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_西南财经大学.jpg	f	english	2016-08-25 16:55:40.318+08
c46ac8e7-87b8-4aa9-82a4-6678100ed8e7	北京化工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京化工大学.jpg	f	english	2016-08-25 16:55:40.319+08
eee8baa9-2e6c-4bc5-b106-afc238eef626	东华大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_东华大学.jpg	f	english	2016-08-25 16:55:40.32+08
582de426-1c98-4efc-a105-daff5169e688	南昌大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_南昌大学.jpg	f	english	2016-08-25 16:55:40.321+08
b68d5ebc-75fb-4a87-bdcf-c6a39b0dded8	解放军理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.322+08
c2dcd104-7cde-44f7-82b3-4ed58d383f2b	中央财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中央财经大学.jpg	f	english	2016-08-25 16:55:40.323+08
6c325dba-f8f0-4389-adbe-677e41b92702	北京工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京工业大学.jpg	f	english	2016-08-25 16:55:40.325+08
658d2ebe-8df5-42b0-be66-1e04f25f913e	福州大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_福州大学.jpg	f	english	2016-08-25 16:55:40.326+08
ceff782d-8932-4346-9706-ff4ec7d4ab75	广西大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_广西大学.jpg	f	english	2016-08-25 16:55:40.327+08
54e95163-89de-4b15-83b8-80aa20d883ea	陕西师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_陕西师范大学.jpg	f	english	2016-08-25 16:55:40.328+08
c9de3d9d-fb02-4423-b9ee-b3323d79e8f3	深圳大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_深圳大学.jpg	f	english	2016-08-25 16:55:40.336+08
eadb6d36-7c0e-4b05-95c0-a3ac21825c21	北京林业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京林业大学.jpg	f	english	2016-08-25 16:55:40.337+08
9994435d-240e-4fbc-a302-94d15108de27	中央民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中央民族大学.jpg	f	english	2016-08-25 16:55:40.338+08
fe4e4a5c-d43b-4b5d-a2d2-da1aa98a1967	对外经济贸易大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_对外经济贸易大学.jpg	f	english	2016-08-25 16:55:40.339+08
37dba3f1-987c-4711-b7af-7c6d77453508	燕山大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_燕山大学.jpg	f	english	2016-08-25 16:55:40.34+08
9355cde6-d1ca-42bb-9004-97907ffe87d0	首都师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_首都师范大学.jpg	f	english	2016-08-25 16:55:40.342+08
df6e643a-b679-446c-b3ce-f314f2390d24	华北电力大学（北京）	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.343+08
3ccb1171-e80d-4915-9cee-34cab7bc61d2	浙江工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_浙江工业大学.jpg	f	english	2016-08-25 16:55:40.344+08
db9249e3-4d84-4099-a84d-64f8deb7f13d	华南农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_华南农业大学.jpg	f	english	2016-08-25 16:55:40.345+08
0eeede28-d688-4b17-a9a0-50eb8329bf3d	浙江师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_浙江师范大学.jpg	f	english	2016-08-25 16:55:40.347+08
ff9991ae-912f-4cb5-90ee-f196b3462fa4	安徽大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_安徽大学.jpg	f	english	2016-08-25 16:55:40.348+08
fc1d3b1b-10b4-47b1-81c8-96408ac71a01	首都医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_首都医科大学.jpg	f	english	2016-08-25 16:55:40.349+08
3525440a-2216-488d-b1eb-1fdb3ab9e0b3	江南大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_江南大学.jpg	f	english	2016-08-25 16:55:40.35+08
159c9efc-5850-4581-86a6-bdc9af0a2f46	山西大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_山西大学.jpg	f	english	2016-08-25 16:55:40.352+08
b20c3faf-540b-4e95-a4c6-efa57eea7d89	太原理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_太原理工大学.jpg	f	english	2016-08-25 16:55:40.354+08
0c270985-8bc1-4ec2-a038-1d5f4c56f4da	东北林业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_东北林业大学.jpg	f	english	2016-08-25 16:55:40.355+08
249e5adb-0d62-4bd5-a2fa-7470ccc2c51f	河南大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_河南大学.jpg	f	english	2016-08-25 16:55:40.357+08
0f867cfc-5b06-4152-a0cd-6449d3d96951	福建师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_福建师范大学.jpg	f	english	2016-08-25 16:55:40.358+08
504c271e-f284-4374-932c-e521780295ce	杭州电子科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_杭州电子科技大学.jpg	f	english	2016-08-25 16:55:40.359+08
466eefe0-8d9a-4a00-8868-ebc2e6a5a462	内蒙古大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_内蒙古大学.jpg	f	english	2016-08-25 16:55:40.363+08
e59b9ca3-c086-42eb-9e51-a0b18e2000b3	天津师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_天津师范大学.jpg	f	english	2016-08-25 16:55:40.364+08
b7597402-1116-485a-aa61-794b2834c8f0	河北大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_河北大学.jpg	f	english	2016-08-25 16:55:40.365+08
d10e0b4e-fcb3-4f38-9c10-86125b5cd1a3	南京工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_南京工业大学.jpg	f	english	2016-08-25 16:55:40.366+08
4d7320a7-e632-4297-bb57-d6b0448b1057	辽宁大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_辽宁大学.jpg	f	english	2016-08-25 16:55:40.368+08
7232cbf8-9f59-448d-bef3-e92b739a91ae	新疆大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_新疆大学.jpg	f	english	2016-08-25 16:55:40.369+08
14ba1ee4-b4c8-43bb-a2e8-b58c0487f44b	中北大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.462+08
5c80eb6e-3039-4b01-91bd-27852adb9fd2	南方医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_南方医科大学.jpg	f	english	2016-08-25 16:55:40.37+08
d33d93f3-eadb-45cc-a5ff-1b0a281a1db6	上海理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_上海理工大学.jpg	f	english	2016-08-25 16:55:40.372+08
55e45c70-e7a4-46f3-954b-bb8c42667c2b	海南大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_海南大学.jpg	f	english	2016-08-25 16:55:40.373+08
c6c187b0-2628-4737-ab44-841dd3bd3b59	东北财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_东北财经大学.jpg	f	english	2016-08-25 16:55:40.374+08
3e11fc8a-287f-4d9c-b926-f612159888f3	昆明理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_昆明理工大学.jpg	f	english	2016-08-25 16:55:40.375+08
bd52d026-79ac-4a4e-8356-ac7503cae032	石河子大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_石河子大学.jpg	f	english	2016-08-25 16:55:40.376+08
07fbef6a-30f1-4e86-bf61-93842bafb4a7	成都理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_成都理工大学.jpg	f	english	2016-08-25 16:55:40.379+08
477dd4f7-ff67-4a1f-a283-291e5b952af8	北京中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_北京中医药大学.jpg	f	english	2016-08-25 16:55:40.38+08
6f2e3775-2b0a-4033-8717-c41f329a1967	安徽师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_安徽师范大学.jpg	f	english	2016-08-25 16:55:40.381+08
e48c394c-95b7-438c-a58e-aa6c001a0e84	天津医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_天津医科大学.jpg	f	english	2016-08-25 16:55:40.383+08
d3068c8f-574f-48f1-9e9d-19b38b0a3aea	黑龙江大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_黑龙江大学.jpg	f	english	2016-08-25 16:55:40.384+08
47573307-faa9-48d2-88a4-1fc7d6b37aa9	汕头大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_汕头大学.jpg	f	english	2016-08-25 16:55:40.388+08
e2fe5381-61c5-444b-8a3c-f68583b0552b	中国药科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_中国药科大学.jpg	f	english	2016-08-25 16:55:40.392+08
4c85da88-e6f2-4d8e-9058-c50548c8a287	湘潭大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_湘潭大学.jpg	f	english	2016-08-25 16:55:40.394+08
51dbfc15-9737-42df-8d98-38af3b5310ee	江苏大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_江苏大学.jpg	f	english	2016-08-25 16:55:40.402+08
6aa5f07e-11bd-4671-bf8a-0b3557811b53	贵州大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_贵州大学.jpg	f	english	2016-08-25 16:55:40.404+08
d170c2db-313f-46e9-8491-d665cb3decc6	扬州大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	https://s3.amazonaws.com/lymchat/pics/college_扬州大学.jpg	f	english	2016-08-25 16:55:40.416+08
69b3cf55-71d4-4bc7-b356-34c37b5837cc	西南政法大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.425+08
95181d02-b3c6-4fa1-8762-4f0d17c24b41	河北工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.428+08
a75f83dd-75a0-451b-a540-14ffb91d84dc	东北农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.429+08
fc252c05-4917-46f3-9098-882f87fd3386	四川农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.431+08
50cedbe2-8091-4811-be59-f12a36b8c5ca	福建农林大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.432+08
c927fad3-0bed-48e4-8f96-4be2ebef6b25	宁波大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.433+08
7b755aa6-d0b4-4228-bcc4-2b6d20dac717	山东师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.434+08
7b6c6b78-de66-4f4c-858f-c9566657f20c	上海师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.435+08
9c515751-1185-4c64-bb5b-0df988e934b7	西安建筑科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.436+08
c2c1b02a-e187-4987-ab64-78269c19ed0c	大连海事大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.438+08
2d6dcf31-db56-40f0-a0e9-344e9f55dc99	哈尔滨医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.439+08
af006dbb-d5a8-45f9-a35f-fc48c42c20bb	宁夏大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.44+08
3cfd9ade-1b3d-48f9-a6cb-ad1e1d7796f6	西北师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.441+08
e6d076ba-07de-4cc5-b545-4925ca98537f	湖北大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.442+08
b1b4ac36-b9b5-4eda-933f-2817dfdd8af0	中国医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.443+08
caeb54ba-1fd5-441b-bd6a-0417444bfe87	广西师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.443+08
02536130-708e-4d1c-b28c-4f5854954fe6	西安理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.444+08
b3f659dd-0571-444f-b92a-720541bc4a5f	南京邮电大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.445+08
e1707a7a-5efe-45cc-8d7e-aba9f363a095	青岛大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.446+08
263ee9e4-6d37-43d6-84bd-0d5baee53969	江西师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.447+08
cbf7ed6f-544c-4789-9e0f-602ae23206ba	河北师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.448+08
176ed23a-b4d0-46b2-a51b-fec4a6b6847c	河南农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.449+08
450774c7-bcf9-4d25-82f0-680cd30bb8ee	湖南农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.449+08
57d92fc8-76ec-42d9-a926-188c5ac353d9	江西财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.45+08
6da821d7-68b2-4128-80a9-f93b73fd7296	首都经济贸易大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.451+08
df85df5a-8c21-473d-bad4-78ed733dbd54	长春理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.452+08
4d5eb509-eb63-48bb-9733-64cd01dd761d	山东农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.453+08
84caa099-a838-47d5-a2d2-76afe81dcb5d	广州中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.454+08
c4d81232-a4b6-4631-96a8-c96eea1732e3	南京林业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.455+08
7b0154a6-d636-482e-838e-a1918dc9ef44	广东工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.456+08
0ff9d13b-8424-4b8e-b57a-aec467105880	重庆医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.457+08
fc0da5ef-f21e-492a-8d77-5bc7b137e153	广东外语外贸大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.458+08
f53a22b2-a8fc-4fd9-a3a9-d1980bc5d0eb	延边大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.459+08
2c795cca-8967-4ba7-a32f-f916c2e74869	上海中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.459+08
38ff0b6c-fe9a-4db0-991f-12ec40bbee7d	南京医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.46+08
48aef56c-7bba-4c71-a9fd-8fac53f5025c	华侨大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.461+08
edff5f6e-323a-42a8-a130-f50e4617e3fb	山东科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.463+08
fd6d78be-5ee6-4a45-a93f-2e86b9c6986b	西藏大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.464+08
00092ef4-e80d-44b2-9c81-2b0059e07f26	天津工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.465+08
7406d4ef-def9-4a61-8c81-ca4532a6b75c	长沙理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.465+08
3a2dc8c5-cc39-4b05-b4da-7d16809a5a90	河南理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.466+08
d1ca239a-8a43-44ea-840d-b06df863403e	北京语言大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.467+08
08f077e4-63e4-4983-a74d-5aa986b79bcd	河北农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.468+08
014dc98e-4279-4911-9636-0fc7f275ebc9	云南师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.468+08
bdcf6527-1ed8-4081-88db-d3ff98e9dde0	哈尔滨理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.469+08
1466097f-8ade-47d4-9bbe-1fa39a36ed14	武汉科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.47+08
7d803841-81b4-47dd-a0c0-632447ea9836	辽宁工程技术大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.471+08
d614a512-6a6b-49c7-8641-fe271c20aa05	广州大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.472+08
c0237659-02df-4ace-9e29-7bb029afd36d	南京中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.473+08
ad2d5c53-7e05-4d65-b588-b74007faf815	河南师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.474+08
ceff7e07-dfd8-4429-ad4f-6c7402bc776b	兰州交通大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.474+08
95d6f8ca-3606-41a0-aeac-256b49f1593a	华东政法大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.475+08
f571dcff-804c-4e49-9543-ef21382f3f59	青岛科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.476+08
7da33e5d-4eda-4a4a-8d71-8be4437368ea	东北电力大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.477+08
270c792c-3a70-4e89-b31e-0d8357cfa689	西南石油大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.478+08
1cf1ca84-6d29-458b-8262-b462a1702f12	杭州师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.479+08
cc981604-ac19-4f51-a1c2-8c29c9731ff1	青海大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.48+08
31682486-f432-4291-bd2b-46b02e21e348	安徽理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.481+08
aac5e16b-8307-4965-bc08-7b20bcf7df37	浙江理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.482+08
3503bf59-37e3-4872-a4d2-c48254816c95	河南工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.483+08
d1c05575-7844-49e4-bf9c-9458a811b650	沈阳农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.484+08
924a15a8-9c06-47e5-bb69-3a83b7538ce0	东北石油大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.485+08
8085f99b-0c61-4aae-b63a-e1c7bb445d3e	哈尔滨师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.486+08
9518f605-a2b3-4e39-a02d-b0fb48c7836f	中南民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.487+08
b3f2c326-a13c-4ac8-b2f5-803f41b47462	温州医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.488+08
1720c5dd-a5f1-4bb7-913a-75c1b94bdf92	天津中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.49+08
5c048cbf-9b37-4aca-b975-6c5958979334	内蒙古农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.491+08
6ace1c22-1761-4ed3-aff6-f1675f34ff38	云南民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.492+08
e46961c5-aa45-4ae1-92b8-7892caee36ab	济南大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.493+08
534be3ec-b9d4-4ac8-8feb-137d7d0f87c4	中国计量学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.494+08
6df6d7e9-61d4-4db8-b2da-87f5117c62fe	沈阳工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.495+08
579aed70-7d7d-4e72-8f10-fc946cb333e1	浙江工商大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.497+08
36511d26-4d15-40ee-bd48-13a01ba1bd8e	安徽农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.498+08
eb98ee07-55cc-4ad6-b1b3-8246b1b4ae37	重庆交通大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.499+08
04ab249e-e90a-4eed-aba7-7fd644aa423f	重庆邮电大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.5+08
0dce4872-a6b8-4989-bdd0-5b70a1767179	西安科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.501+08
ddb47d7b-96d3-4dee-9923-b095b5013ca3	成都中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.502+08
f733d882-e4d0-4cb0-a673-289c8429a23c	四川师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.503+08
f0da37ab-9f5f-423d-910f-8cff191c37cb	安徽医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.504+08
c70eafed-4a2f-4209-bf21-cad702dd0b72	上海海事大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.505+08
79ba87b5-28c8-42cc-99a4-b8d6cf5fa1a2	安徽工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.506+08
03a4bf56-618d-4b83-823b-d9a17f20227f	天津财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.507+08
671a3c9a-c7ac-42f6-8382-d3168e2c1f44	大连医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.508+08
f5747ddc-a673-461a-a34b-ae4f4da72433	兰州理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.509+08
d6937b54-1e2e-405b-ad1f-cdc57cd4ea22	上海海洋大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.51+08
16c1bd77-072a-4b43-a92a-a3b06b15ea8a	南京信息工程大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.511+08
03df6dae-853c-4bf6-ba4b-4b3b30956eeb	天津理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.512+08
1100c71a-a63a-4859-89a6-3cafda68cdad	三峡大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.514+08
d113d64b-bbdf-4733-985e-7cf1a737e07e	北京工商大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.515+08
0df69836-fbb5-4700-86c9-e8c330d96d97	内蒙古师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.517+08
9ca56474-bcc2-4d15-85d0-89cf1dc73b02	辽宁师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.518+08
374c5332-93b0-491c-8caa-c1c88fd5e2cc	中南林业科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.519+08
b97e5ad2-d286-4fc0-8149-1e129d616ec9	河北医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.52+08
c83f6461-05a5-4aee-89ac-f654daff72b5	长江大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.522+08
755c0376-a4a4-4dd2-857c-2c406d658958	云南农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.523+08
1bd9d8f2-1479-4bea-8c6c-60fafc8762ec	吉林农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.524+08
665faaab-235a-4b0e-b49d-c100f5504267	江西农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.525+08
25d7daf1-96e6-4fa6-8ee4-972b432ff8c6	河南科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.526+08
14561941-649d-4a98-8573-0cda9cfea395	湖南科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.527+08
a9d41595-4a4a-4e27-a4cf-0f8f8aea60cf	南华大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.528+08
dc4adf67-5754-4136-b924-38cb66e96adc	广西医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.53+08
e001d751-8146-4bf5-9289-e99f7c5f9738	贵州师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.532+08
8b640d2c-5c3c-4c78-8647-e09fb501e6f0	新疆农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.533+08
a7f8915c-1314-492b-80c0-60fba5bbf138	新疆医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.535+08
8377650d-4572-4ac8-962c-1d92a0b9f465	天津科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.536+08
6a6b37fa-a53b-4c39-887d-fb469707e52d	江西理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.537+08
07c5740f-dfad-401b-9461-157cb9c01002	黑龙江中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.538+08
2a59890c-c255-49c6-b9f1-13c6e4837be6	陕西科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.539+08
6cb2d079-0f1e-4731-80a5-b2bc846ccb40	沈阳建筑大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.54+08
5fd9b614-6d23-41b2-bc76-9adba716be80	长春工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.541+08
e991193f-1fca-4a22-a64c-9bea63f0243a	山东理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.542+08
b6d5cc89-ddb6-403e-af87-a9846fcc3f5b	桂林电子科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.543+08
3776079b-4c80-45af-b54a-0246da60dbac	安徽财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.544+08
8681e2c7-744d-4919-bbb4-4913c1bff9b6	南通大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.545+08
9100a614-76d3-4376-b599-2aeff92c72d5	湖北工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.546+08
25db7a3c-7158-459e-b743-2a54edb7d9f2	甘肃农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.547+08
8ef5538f-48f7-494d-a77e-46bf8d550bfb	石家庄铁道大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.548+08
96996216-6072-40f9-a7a3-35af6daae1c1	南昌航空大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.549+08
83cf41cd-673b-4555-ac77-38d2b69a5172	西南科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.55+08
08c77091-cee7-460f-a16f-6fd29794eb59	沈阳药科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.551+08
7dc6c887-4c03-4327-88a4-c78192c48415	青岛理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.552+08
cef8d219-1302-449f-aa6f-82230911ad14	内蒙古工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.555+08
d1caf7c1-f799-496f-b7cf-c604b33de5b7	新疆师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.556+08
566bfff8-b659-43a1-ab11-c6effe445104	江苏师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.557+08
daca1fa3-81d7-4a24-8658-6abeb75a3367	曲阜师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.558+08
4950531a-3baa-4fbd-bf93-489fd7b99fed	桂林理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.559+08
e51ef914-a3ff-4901-afd9-561ff5d4b10b	河南中医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.56+08
62d53b3f-c275-44eb-92b4-8c8b3b2d3a6a	西南民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.561+08
a267956f-42cb-4716-ad19-adb378226fa6	山西财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.563+08
7c99177d-69ef-4f60-a8ff-6b64ca78588c	重庆师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.564+08
cfde6fd3-324f-4ae6-aac0-ac870d7e58bb	重庆工商大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.565+08
6847a83e-317d-4da5-b13d-b59b2a5a2638	武汉纺织大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.567+08
a723b80d-59f9-4923-b2ec-5f55c29f13b0	华北水利水电大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.568+08
bc67acd6-02cd-4623-a3eb-5cdbc223e5ed	华东交通大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.569+08
14994439-2f9c-435a-a226-bef9a3cfe0b4	广西民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.57+08
0ddb9445-a772-43cc-a4ad-62c115cc548a	云南财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.572+08
519fb1c3-8055-49d7-8ce0-2c811873062e	昆明医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.573+08
b6b5c47c-6615-4504-b056-eedaa76dccd5	上海工程技术大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.574+08
f842b914-388f-46c6-a78d-9b32e2380010	山东财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.575+08
1a322ad8-311f-47eb-b90c-a5845a8c95bd	大连交通大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.577+08
54cb8b27-d938-487f-92c2-ee01c3ab4d4d	江苏科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.578+08
f90e4858-b36e-4874-85ec-25b5f04b726d	集美大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.579+08
db10f489-14b1-4968-a065-95981a448ca2	烟台大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.58+08
9a342d53-ff52-4fc0-8804-924c9c284f21	河北科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.582+08
e559be77-58f0-45eb-a0af-72422d167eb1	南京财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.583+08
93cf29d6-74bb-4d69-bd0a-f417f4578238	中国民航大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.584+08
68ccd420-b613-4b89-9e60-509356222a92	浙江农林大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.585+08
1457e676-d05d-4d53-9dd0-e33b91a5de59	成都信息工程大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.586+08
6e409811-172c-4214-bc32-d5c08844cac6	哈尔滨商业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.588+08
c25647c5-99f8-4da8-ad91-7b473fffea33	温州大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.589+08
789cafa8-7608-41dc-8278-b8ed73956855	福建医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.591+08
4dc97fd3-6100-41b2-b839-630425728d60	东华理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.592+08
4cd50cc6-e74f-4927-aa23-0895483d7057	广东财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.593+08
eda3ccad-058d-4548-b760-0b8bb1cdba74	西北政法大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.594+08
2ccae7f4-bee3-4b52-a77c-648abe7118f8	山西师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.595+08
5c1bae1f-fc87-4bfa-a82c-0f81e41f1581	沈阳航空航天大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.597+08
7695b13b-3186-474c-b11b-70aa61b85bd4	武汉工程大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.598+08
6b6d43ba-2946-46c5-af72-e6b60dcc348c	山西农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.599+08
fbb3e578-c488-4b8a-ae8b-f9b035172ab4	广州医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.6+08
00b2a40d-5573-4706-9970-de386bc44d73	浙江海洋学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.605+08
1c45015a-4b49-4962-a7b5-7a92cbe000d0	西安石油大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.612+08
92db03cb-cf04-4a8e-be7c-cc4555afab0f	内蒙古科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.615+08
99c97536-d11b-43f1-8d3b-c16a07dd1b74	大连工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.617+08
489dedb4-f917-4dcf-a10f-d5570ef7a5ef	湖南中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.62+08
8c9e44d2-e13e-4b5d-b674-e5dc4dd920a9	西北民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.622+08
7254c47b-50d3-49a3-917b-41672600a44d	宁夏医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.623+08
814e7680-2553-48a8-9dd8-4e22705af46c	山东中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.624+08
dd59e041-d61d-4049-9518-abd329318af9	大连大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.626+08
7df1faf8-e65f-4af4-a79b-c4c64f6f7dad	重庆理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.627+08
a72eee38-c78c-4733-9145-3a0f5dad8582	郑州轻工业学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.629+08
ac83f234-f0ba-461e-ad91-db5e047fd361	浙江财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.63+08
cec88784-af58-4708-a541-b3973cdbf839	北京建筑大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.632+08
ede7bb6f-9e86-49e8-93c8-fbddc82afe8e	山西医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.633+08
6ea13db4-fa92-47d5-a245-19341be0607c	河北经贸大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.634+08
0deb8748-d04a-4fea-b4ae-d6ab5d0550f6	吉首大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.635+08
bbdd6ec4-e3be-45bf-8252-ce5c5fb3dd19	西安工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.636+08
ddf41be0-57c1-471d-9f0a-68fd2842c288	华北理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.638+08
eb75a636-c96f-46ef-9afa-d00e69bfa645	沈阳师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.639+08
d6cbd6b8-4feb-4370-a615-16cf69c18b79	常州大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.64+08
0b85a224-91ba-47db-a545-4869fcac657b	海南师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.641+08
e986df68-575a-4802-8b34-4517c4434c78	吉林财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.642+08
87aa62be-5135-4ea7-b316-ad952d05601e	辽宁科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.643+08
5ea7551e-608e-4d65-a85f-f2adadb7a1cd	西华大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.644+08
d924f84c-d7ef-4f72-8e13-7087c9da0078	西藏民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.645+08
944adf54-1dd7-4a47-bf31-3c1293c7b6ea	西安邮电大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.646+08
6bff3e66-d077-4e21-8fc1-910cc9cea114	北华大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.647+08
6343e5d2-f16c-4970-8bd1-1cb7198ef5eb	吉林师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.648+08
fe387061-d4c1-4b7e-84bc-f0762a766916	景德镇陶瓷学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.649+08
7f515c14-f2c3-401b-b073-159ad91d6d7b	太原科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.65+08
1e12b961-2331-4a5c-852b-6a8aa8f801a9	辽宁中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.651+08
81797df3-3b3b-4f3c-8c91-9f67919b1237	青海民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.652+08
0987b658-a7c9-4175-8529-fa548f024436	鲁东大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.653+08
a90c5813-b4ed-40b5-a8b3-54d730519d30	贵州医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.654+08
cb156dd8-b696-411b-a709-6ca27463f36f	山东建筑大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.655+08
5d7f5472-4cdb-4ab6-a567-f2cc45b6090e	北方工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.656+08
da67e501-2b51-458c-8f73-aa9972e8264b	长春中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.657+08
4ddd8b72-3d55-4643-ab91-d82371e4b5d8	湖南工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.658+08
ee122a2c-6ab3-4820-950b-7f7fc0f788da	上海电力学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.659+08
6e19af36-be3b-4755-b79b-1e1fbbadc8f6	河南财经政法大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.66+08
a59494a9-f72a-4177-86bf-5ca738d44813	西华师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.661+08
e646a126-2308-4f21-8340-83626aac662b	贵州财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.662+08
7f1ae784-f462-4bea-b979-6e360d2628c3	天津商业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.663+08
10dc0422-f954-4d27-8162-4858ac5741e5	贵州民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.664+08
fe832951-4dd2-485e-bbb3-9e85ca6999c0	沈阳理工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.665+08
68cd897f-663f-4ba8-8b04-64912d98ff44	江西中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.666+08
2bf8e66b-8491-4c67-8da9-a2a00cc6dd7a	浙江中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.667+08
50943257-6422-4317-a112-964095e4ce30	齐鲁工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.668+08
7922180d-a358-468d-9532-f3bd00d59715	淮北师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.669+08
044376b5-ee82-4300-af23-139998556595	青海师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.67+08
16815a47-3782-42bf-b7fe-d34cf7fef82c	北京信息科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.671+08
853dca04-de48-4b45-a98b-f782beb68fb5	北方民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.672+08
2b630fbf-823c-45f8-8c5f-60eb228a1637	黑龙江八一农垦大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.673+08
3d037988-2d05-4cc3-9765-6664b59bc8e9	西安工程大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.674+08
3cc7639f-e90f-4a5f-a0fa-12e992dff137	安徽中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.675+08
cc4022b4-858f-45d9-ae50-6dbd69fd0dba	黑龙江科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.676+08
b0e27a98-0957-48e7-88ff-817f27c0d493	齐齐哈尔大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.678+08
742b5a85-e183-4230-ab42-e1749c36b899	东莞理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.679+08
1351d88d-b724-4d81-bb7c-2f773c413385	河北工程大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.68+08
5a1149f7-50a7-41f9-9759-48127b31d2fd	河北地质大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.682+08
239339ab-0517-4bf1-8f3a-1c729bb01239	内蒙古民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.683+08
9e080b9d-15a5-4d64-92d9-6bd06035744b	大连海洋大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.684+08
a44306f8-f73d-4e64-b052-ed921d06046a	新乡医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.685+08
a71af4df-862b-4bc0-babc-381e9ea4dba4	湖北中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.686+08
f9749819-b89a-41e6-9cd0-ff022452e33b	西南林业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.687+08
0abcb7ef-7ed2-491c-bd9f-4aae2ce178aa	辽宁工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.688+08
badec636-0790-45d1-9981-86afbfdaf75c	中原工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.689+08
8ac54996-b8ff-4def-a5b2-fd598fcb5c1f	信阳师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.69+08
5e6b8a37-bd60-48b1-966e-148d5e17b754	塔里木大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.691+08
42700159-5cfb-4e40-943a-87400982ccfe	福建中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.692+08
a8a0555a-2b29-45a5-bafe-938a0608c3d0	广东海洋大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.693+08
2e31ec9b-c073-48bb-a677-cdf385605848	北京联合大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.694+08
873df351-ba0c-488d-b712-77e5dffaf64e	大连民族大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.695+08
498a53a6-e0a2-4bec-8de6-c7334979536d	聊城大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.696+08
52e49c02-68b2-4851-a635-dd0f8ed2f727	延安大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.698+08
2933ba66-a5aa-4884-9528-b467ae5ddaaf	长春大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.699+08
193dfe64-f682-4a3d-b464-bd16e77ddbf3	安徽建筑大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.7+08
e5e15a38-7501-4040-ad6e-cae0fea2de1e	辽宁石油化工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.703+08
0739ffe8-5187-4ba4-9e1a-6707ae5ec249	武汉轻工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.705+08
2423de75-4c0b-4fe5-8d44-8aa64dc8a925	北京服装学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.706+08
df23235d-a0a1-475f-b54e-7c6d619f9e34	徐州医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.708+08
5d541445-0ae4-413b-8fcc-7bba2f8d8c8e	沈阳化工大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.709+08
46b73940-5cd0-4103-9e6e-24e536885e2f	南京工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.71+08
ec430762-3538-4f54-8051-7d3f123de0bb	吉林化工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.711+08
f644cdb3-4b50-442f-8952-f9a968251a57	广东金融学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.713+08
f18176af-d3e5-4873-8a71-fc5967baa51d	内蒙古医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.715+08
0d0918b1-e094-4b33-bbe1-01f7ee2fd6f6	广西中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.717+08
f1bc7c93-e398-420e-8afe-dbb5dbff490d	上海应用技术学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.719+08
52c69220-45a5-482c-8d14-5bf540e6138c	上海立信会计学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.72+08
93aacc41-b72e-414b-9a2c-b659b00c71b8	南昌工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.721+08
72485140-2fe0-4154-a1aa-869a03f8eb2e	西安财经学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.723+08
7148fa14-8ae6-4845-9869-b3df831b349a	广东技术师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.724+08
3a3e51e6-1cee-469b-9278-6b17623d66de	新疆财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.725+08
84c6bc81-9e6c-4b2c-9e5d-59ca43be2c90	佳木斯大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.726+08
4e80d07e-0fbf-4537-8014-761758e87a27	商丘师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.727+08
ab8edccf-b866-4db0-b8a2-08aeb39bfcd7	贵阳中医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.73+08
7be947ab-d176-4ca0-a106-887e1f393985	南京审计学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.731+08
bfb3b2e9-ae67-427e-bf5d-fdb63b3e4e98	中国青年政治学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.732+08
0df196bd-cee1-4a72-9bbe-437b9697cf08	渤海大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.734+08
8984fd8e-0e13-4bca-a5e9-71790febc75a	绍兴文理学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.735+08
c2aaccd6-9ad4-417b-827f-d6ce44c736a0	安徽工程大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.736+08
c6ff25df-0c9f-4c2b-b6b4-8113d08a68e7	广东医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.737+08
9242be68-b384-48f0-8b73-5cf5eb51427b	合肥学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.738+08
f176617c-9696-49d5-a26d-f1bf7a51b8c3	黑龙江工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.739+08
91767cd3-92ef-4b43-9a01-16e9f4cc6f9e	赣南师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.74+08
3ec3e39a-2d4b-4458-bbda-149625bff05e	洛阳师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.741+08
ee11359c-c250-46db-9307-1a522eb597ba	苏州科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.743+08
91b33a62-05f7-4434-afe3-0a2c945d1e74	安庆师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.744+08
ce9279c5-c24e-4efc-b7e6-05601d8ab36c	福建工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.745+08
621e26c0-4858-4984-80b9-b2b15c46595b	青岛农业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.746+08
6ccb4b4b-020f-4cf7-9b5f-8f34e3f339ae	广东药学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.747+08
3a4f0c66-3160-49a0-81eb-98ed075bd5c5	四川理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.748+08
a5d0d2f7-df99-4057-aee3-d967dc389282	井冈山大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.748+08
3c273c2c-eac9-49e2-ba37-2634c9a7d845	遵义医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.749+08
9c6f60de-a58a-4dda-9127-526006e9d6b1	河南科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.75+08
daafb201-8ec0-41b2-923a-b3917f7dec97	厦门理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.752+08
c4e9b73f-696a-4b80-9033-cb416a2ed41e	内蒙古财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.754+08
2bba651d-9674-4d10-9575-21945647d103	北京农学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.755+08
90533b89-3320-4b3d-9c8c-4a601c1eea4a	湖北民族学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.756+08
c822f263-0c53-4f21-982c-6a356b326bff	重庆科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.757+08
dd46e1d2-3851-4b1b-98bb-81186f2bc6cc	临沂大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.758+08
ed09883a-8d46-448b-8e5f-187e73ebef5e	湖南商学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.759+08
e196b833-a0bf-40f5-829e-f337be65198b	广西师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.76+08
d8ef33f6-e771-475c-af75-a5bb601bc6e8	广西财经学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.761+08
e6a6f31c-f510-4e6f-b8e2-2d3ff9d06d43	湖北经济学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.762+08
d13a335c-8308-46a8-abe6-4a2adabdd65d	上海第二工业大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.763+08
f0c28869-787d-4b6d-b347-7f8d5f31c999	江西科技师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.764+08
2d465ebf-8537-46a4-aa06-7fa6c1c953d9	天津职业技术师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.765+08
83b9d325-478d-45f9-b1fe-f108ba203701	湖州师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.766+08
d0149b39-8bf6-494a-9f5a-a6548d97b642	沈阳大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.77+08
216c086f-6d2e-437c-b2dc-8ede89838a5d	湖南工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.771+08
92c85bfb-ec19-4ee6-bc8d-c7f8159ea781	闽南师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.773+08
6025994f-6198-408f-afd7-c6b7684ca535	辽宁医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.774+08
8c71a79c-4c99-4995-9bab-70eabc3d37b6	甘肃中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.775+08
f50f118f-e513-41b7-b375-e269a2e623c2	兰州财经大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.777+08
8f2735ff-7fcd-4782-8a22-7ca680ccf1af	山东工商学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.778+08
985bb0d7-fa8a-4255-9cae-01ef61b185de	唐山师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.779+08
6179582f-9e84-4f3b-80be-76111d76b750	浙江科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.78+08
daf5f0fa-1f60-41d9-b214-b1c57e9c17f3	沈阳工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.781+08
28d4d169-de61-4112-8b1f-3bc51452ec00	合肥师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.784+08
e0e23e1d-61f3-4b81-bcbb-77c580d1ff99	北京石油化工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.785+08
2bd2dda4-6b48-419d-804f-f2c0a07c16b9	泰山医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.786+08
921bcd49-1b88-4f3a-835a-e1749bcbd7fa	桂林医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.787+08
f9729d0a-0f92-4c37-9b6b-f58bc6401c6d	乐山师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.788+08
90a3130a-2176-4bd9-8fb2-6fba3985aeb4	上海金融学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.789+08
5c5d79f2-a738-4948-a343-23213cce03b2	上海政法学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.79+08
98c32ebd-2ade-4b82-a355-05cf1e2a40e9	长春师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.791+08
d046c98a-5c19-4e77-86c5-ed3de9ef5a85	北京印刷学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.792+08
a299b72e-b10d-44f1-a741-1f5786bddd51	西南医科大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.793+08
83f5b53a-a023-4179-adc1-c7160c5a9b7b	大理大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.794+08
7a9bc6be-182a-4274-8799-dd443244b785	江汉大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.795+08
ac02f988-55fb-4387-a9df-469b32e363b0	北京物资学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.796+08
e85442da-7347-4273-a8e0-aaf23f9be4b0	天津农学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.797+08
c84925a0-a476-433b-bf09-e21a9e8b2f11	郑州航空工业管理学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.798+08
7aa7b07b-19ab-44e8-99b8-c00557e1bf5e	川北医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.799+08
2a5aef73-1607-40e0-ac06-7526017b2602	重庆文理学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.8+08
80386a51-0c1f-4d33-ad14-b2b61404c294	河北金融学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.801+08
cb6a3ad9-67d9-4cb4-96cd-f7faa24c5d38	海南医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.802+08
fc37954f-7f4c-4196-8519-3ce9cfce6505	蚌埠医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.803+08
6c643d59-9739-4d11-9ebe-e906411a80f4	闽江学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.804+08
07049859-5316-4bd6-b0a7-1f4dd15da2c8	湖南文理学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.805+08
2d092208-0a58-4d90-a107-8ea1d97c5c2a	安徽科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.806+08
5eb2e075-e0ca-4cb0-aed7-68213f5a9e10	山东交通学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.807+08
2aac3bf8-6a33-450f-a814-c67164667b1c	天津城建大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.808+08
5218221d-f12a-4c63-a88f-be86aad4ff39	广西科技大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.809+08
0e3c4f90-08c6-4097-94f7-9220f2e4dcce	潍坊医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.81+08
16578a1f-fb57-4aee-bf44-b1b4a0372340	浙江万里学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.811+08
601de854-7bcc-4c51-9cce-2b54daa80e98	吉林建筑大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.812+08
e473e45a-3d39-46d6-8f4e-ea579cae3678	江苏理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.814+08
41fcf365-22c9-4942-a0a9-e11e957b8dd1	上海海关学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.815+08
6861e90d-2b8d-494b-8145-e024271330c2	湖北师范大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.816+08
9b02ee76-3ba8-4b9c-b117-1ac9917149fe	右江民族医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.817+08
740daf4a-1ab3-4b8f-be91-3a80d48d454c	中国民用航空飞行学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.818+08
2a98254e-c3dc-43fd-ac0b-262699395a8f	五邑大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.82+08
091bfb91-6534-4394-8699-fca0abd5fe43	上海电机学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.821+08
785e363d-9adf-4a54-9854-4db12e7fa8d1	金陵科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.822+08
a2531256-0849-49f4-acfb-3ecb61dec831	嘉兴学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.823+08
11fb0bbc-3c94-437b-b86c-e95e0c66face	皖南医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.826+08
f2d825b8-fbb2-424b-8c31-c20bf12a2804	黄冈师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.829+08
16d88fa0-4d4e-4527-a51c-abf8e0d8ee34	湖北汽车工业学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.83+08
ccd8613d-42e4-4d3c-8407-91fe01b7af4f	韶关学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.831+08
d332bd9b-8534-4edd-956d-10a7d38cbda1	肇庆学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.832+08
f0c722ab-5228-47a8-8aeb-a0845fca291f	河北科技师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.834+08
77ce4e17-3fd7-4c7d-9f45-36343ee60198	成都工业学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.835+08
f75c8142-1eee-4b0f-8980-25c7609b4630	湖南科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.836+08
082b5d92-fe1f-46da-a2d8-2fe4663ee213	伊犁师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.838+08
341c58c4-a412-47ee-bdd5-0bd4f32f8781	华北科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.841+08
93931019-f8a9-4899-95e3-f09c29e94b78	佛山科学技术学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.842+08
301d28cd-de0a-4b9f-b214-49782694e94e	上海商学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.843+08
04b25adc-df49-4289-aaae-bb0fa39cd3e3	盐城工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.844+08
18543eaa-6205-494f-8cbb-8abab124319b	盐城师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.845+08
d2b1a54f-5091-4549-b14b-43003c6d986f	丽水学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.846+08
6356610c-4e34-44a5-b29d-5d4d15e310c6	衡阳师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.847+08
88708848-30b9-49db-978b-5343100f096d	韩山师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.848+08
931c337b-bbcf-4ac4-aefe-fd15828e35a3	云南中医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.849+08
3c55814d-941f-4641-b20e-d164c8972bd6	中华女子学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.85+08
caab0e0e-773c-40ce-b3e3-012364b56d63	河南牧业经济学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.851+08
4fb54943-9b41-4bde-b6bb-dad1a36604fe	黄山学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.853+08
5a6b229a-7e4c-4c85-b7d2-4cb58e207a77	陕西中医药大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.857+08
c72baab2-6484-481f-ad32-b6278bf4583a	甘肃政法学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.858+08
6fb1b58b-30dd-416e-b53f-277d4cec96fb	南京晓庄学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.859+08
5f6d00d3-158e-43fa-80e5-924b24fb2da4	滨州医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.86+08
66d194dc-dead-4387-8317-f353cce8caa0	重庆三峡学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.861+08
7bf2a2f8-64e3-4b9c-853c-0570a4beee34	喀什大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.862+08
cd7808ae-7983-4520-8fec-6389777cabb9	长春工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.863+08
2b570dad-0ae3-4d91-abb9-f70382ee398b	牡丹江师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.864+08
192369ba-4a57-45d6-ac1a-27ef1152e0d6	安阳师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.865+08
c0f1415d-49ee-4aea-add7-3fab1b2ebbfd	南阳师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.867+08
924b6a49-21c3-40ad-bd80-42f24b49105c	邵阳学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.868+08
77a3d880-54b9-45af-81fd-cb29dd7f0000	防灾科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.869+08
8b95696f-5cdd-4fea-be0a-9955bbc5aca1	浙江水利水电学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.87+08
0825d53d-ad1a-4bc6-8a71-0d3478c9113c	阜阳师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.872+08
0d717060-29f6-401e-8924-2a105f800930	滨州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.873+08
0862c348-2346-4177-a347-b27e12cf3fcd	宁波工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.875+08
faaa685f-f30a-4780-a051-712eebb62d13	南阳理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.877+08
ba0d6159-32f2-415d-914d-f49eaa0a5e9c	西安医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.878+08
5180323c-597d-4e0f-ab42-71ff94f193cf	九江学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.879+08
6ed91449-7fc3-43c5-9ad0-07adb4336c00	徐州工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.88+08
ddff5f0e-d86f-4e8a-8d60-6af1061eafa4	中国劳动关系学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.882+08
c5ed1ab6-7ab2-4d14-9413-56b0247089a7	湖北工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.883+08
3a136bc5-128b-4651-9f4b-e5b8edf4079d	承德医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.884+08
6ac4c9f4-bdb8-4f90-a728-1ee5182b0b15	牡丹江医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.887+08
c32b3ebb-7585-4bc3-a135-8419228188c7	绥化学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.888+08
cf40f805-6546-48ab-abe9-5d1cc0ee61a5	泉州师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.889+08
6d6c819f-23c5-4f7e-87a6-4c1bc807fd62	济宁医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.891+08
2c9c6ddc-c8e4-4778-a462-48e3ee6e8f6b	湖南理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.892+08
1f37ca32-f3cf-4039-a31f-431720e90052	惠州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.893+08
3a54201a-9f78-4be4-82ce-85e62879d36d	仲恺农业工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.896+08
d251d2bd-b77f-465a-9f27-1b1e78363ebe	太原师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.898+08
8ab837b0-fd53-4113-9f13-91b812488a3b	山西大同大学	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.899+08
ccfa050b-008f-47fe-ad8e-a8b6919c0409	赤峰学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.903+08
d8789589-b7df-487e-a483-73b62d044353	沈阳医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.904+08
dcf6b668-6210-46b1-bf56-13f807e4eb36	湖南人文科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.906+08
991d4d33-3fff-4d1a-a123-8f3f0be80a2e	玉林师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.907+08
09b974ca-c7ad-488c-b399-ea44cc9af7de	陕西理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.908+08
f2bd037f-93bd-4ee8-a10b-eaf6380edfc8	洛阳理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.909+08
9792365f-0aa6-4e2a-bb23-ec49383254b8	成都学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.91+08
1bd72758-d4f6-4f06-a76e-a21c8ff5630e	淮海工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.911+08
39d684cb-25e9-435c-b18a-a4058cc64b0a	湖北科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.912+08
b09b2c46-90cf-4775-b9d5-4f03dcf4564f	运城学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.913+08
db1424d8-122e-4805-985f-ba8e416caaaa	淮阴师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.914+08
854dbbae-ad66-4281-bce8-3a8027563d91	皖西学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.916+08
46c1b296-07eb-4e34-86fd-77747b68b452	山西中医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.917+08
a1b986c9-d690-47ac-8ff9-19c0641b4a3c	昌吉学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.918+08
322aae0e-bb75-4087-9682-ca20e7f20268	贵州师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.919+08
843cc577-5876-4e0e-be40-573bb3fd7399	德州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.92+08
68efcb9e-12af-45ed-985e-2830e511f791	嘉应学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.921+08
fc8bdfb1-9c6a-4e83-bf0c-79f9d95fcafb	天水师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.923+08
28abda6a-6b54-4b13-b9ef-270a0fb95c7e	常州工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.924+08
19e8c325-d41e-4f4f-ad3a-ff662aaf882b	潍坊学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.925+08
8b9e75ab-14ce-4a3d-98c5-d43b17be7b6c	楚雄师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:40.926+08
05e33f35-bdb4-481f-936d-c61729c7e3ea	湖南工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.092+08
b1ae7261-e32e-4fd6-afa3-577e426868cc	湖南财政经济学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.094+08
c8661e40-1c1c-489b-b137-e854a03a58b8	北华航天工业学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.096+08
abfa6cd6-cc1f-4a1a-b8b8-9ed1f68f8c1a	山东政法学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.097+08
d62a2805-6669-4db6-ab3e-265b2df0021d	廊坊师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.098+08
c48d1de5-a1f7-4726-9bb2-633cd53616b4	宜春学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.099+08
7fab9767-2dd5-4520-bde8-84d91d225b4f	长江师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.101+08
2ea22c8f-9d1a-4fb9-a47f-da7ea1d5ca63	淮阴工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.102+08
06a7cf0b-31d5-4dbd-92b7-44b735930ea6	琼州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.103+08
d9dea7ed-ed13-458a-a593-a0d4d15e0ce6	三明学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.104+08
5757b9a9-5b3f-4f4a-9e09-6966306f8797	河北北方学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.106+08
a04123ab-f6b7-446c-a000-2d2e7abe65e4	河北民族师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.107+08
359d8289-3ded-43e9-8c46-17830e00a5ee	长治医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.108+08
d20dc014-2638-430b-a73a-f23e66211757	长沙学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.109+08
2430a135-8c19-4f14-aac7-6645d7efa83e	安阳工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.11+08
83eb629e-828b-4d12-86f6-99e329d9861f	攀枝花学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.112+08
4b4b3077-e08f-47da-8015-592231d2a51e	玉溪师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.113+08
ce9d91e6-ba92-481d-b07e-9c2dc9115ed1	湖南城市学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.114+08
6cfad86b-5f16-45af-ab9e-6e3d3495c281	忻州师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.115+08
51bd2378-f322-4d44-b501-2444fba0d6d3	哈尔滨金融学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.117+08
f45ed8a8-82f2-49da-bbfc-a56708a0dd6e	赣南医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.118+08
8d57fe93-9588-433f-921a-90473eb5e9f2	怀化学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.119+08
766fc00f-60b4-4f33-bd11-a2fcb3df14fc	绵阳师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.12+08
1c24291f-a148-4c69-9b3e-e6503cb10910	广东石油化工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.121+08
a35f65bc-126c-4c43-863f-01323743bd3b	黑龙江工业学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.122+08
94434ba2-7836-4ffc-9213-650f778bb1f0	湖北文理学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.123+08
4ae00662-f283-4afd-b14e-cea1f55c8987	吉林工程技术师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.124+08
09743f2e-2617-4975-ac98-3b471a91ae87	内江师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.125+08
2bd60926-bb71-4feb-89c5-ca75940a7e6c	曲靖师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.126+08
78f999fc-c3c4-4a8c-b3e9-e6fc4ab2076a	龙岩学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.127+08
e5879001-5266-4ce4-b6e8-1cd8ad834523	湖北第二师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.129+08
e7ba6d2c-209c-4ecd-9315-ee29c04e4041	贵州理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.13+08
6d00b6bb-044f-470f-a01f-854b8a1133fc	常熟理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.131+08
59f7c11e-45e7-4122-b311-561e82e150fc	许昌学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.132+08
322e1518-7b43-4399-8fc6-84f80f8a996a	黔南民族师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.133+08
ea120009-1e7b-46b3-82a4-78555401d394	集宁师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.134+08
609e3c91-88f9-4cc9-9c5a-8089913adeb9	成都医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.135+08
cf736442-38a9-4c51-9f4b-4ea901d3cade	吉林医药学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.137+08
8b53fc5e-71e0-43a9-94b3-cb14049ed2c8	黑河学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.138+08
28d92fc9-37a6-475f-b750-afaf9df44803	新疆工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.14+08
4fb49093-0c09-400e-85e4-75652165ac5b	巢湖学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.141+08
2b37d15b-e024-474f-995d-38f2928975ce	宜宾学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.142+08
453aa46a-19ab-45d0-abb7-5628688f6fa3	宝鸡文理学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.143+08
b58eb596-1576-4a91-b6f7-8ea3d9ed74ce	黄淮学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.145+08
b4c7807a-b1a5-4306-9a6c-c30a688c1ee5	河南工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.146+08
9a03529f-5ee4-4dc3-ac21-6435327852bc	河南城建学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.148+08
ea189d97-8c75-42b0-a401-7cdc4226919e	福建江夏学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.151+08
e51aabca-e6a5-4a0c-b381-da2c2cf80ab8	西安航空学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.153+08
2e8a7f2b-4d71-4768-8bf5-ef976eb6a604	湖北理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.155+08
60522383-3426-4989-bbc8-0195493efded	河北建筑工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.156+08
ab1e4803-9e77-48f0-92c1-1681370a3a8e	石家庄学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.473+08
e6837e10-4ac7-4634-9fa6-517267265e23	鞍山师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.475+08
b4a9c2a7-87e5-4bf4-a880-10c184889456	唐山学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.477+08
56378d7c-0345-4132-a5c3-43cbc5762fa9	西安文理学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.478+08
91748a8a-fcd4-4451-bbf1-5cd79540e6ff	吉林工商学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.479+08
aacd79ec-1224-4413-bde4-51ea1d8e51d3	莆田学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.481+08
1d0bcedc-48d8-4ea4-9d8a-1a6eb2f5e87d	湖南第一师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.482+08
35d5b59d-84c2-439e-94e1-2d0c0d55d0ef	广东第二师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.484+08
15164804-91ba-4f88-97c1-bf3d7e0d00d5	兰州文理学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.485+08
2ebea54e-b0b7-4d6a-b1d6-313cf2f4ac0e	长治学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.486+08
d8c180a5-5d12-4499-aea3-0d9d71e14149	哈尔滨学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.488+08
065d597f-1f71-43d2-acb0-20140957d409	滁州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.489+08
f66e2f2e-6e90-4c13-bd3b-383ae4d34db9	淮南师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.49+08
3324eb67-ec90-4980-8334-6afb73b6d7dd	西藏藏医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.491+08
62fc1f82-d3dc-4450-a1e3-07eea83ade87	咸阳师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.492+08
552ce293-1735-44f8-9f6a-f477f0397667	湖北医药学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.493+08
66576376-9be5-4539-a30d-cfc2d1c99587	安康学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.494+08
1ac9156a-61fe-455b-b224-b240cc7a0614	太原学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.495+08
a4391c2d-7c18-4d67-b487-7d34d91d8385	信阳农林学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.497+08
c03a57b6-e31a-4d81-808e-813c8680eceb	桂林航天工业学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.498+08
55b3f4c0-333f-4bd1-b4fa-1a6fa5abeee3	北京电子科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.5+08
68519768-d39a-47f0-a724-11283d84364d	晋中学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.501+08
7258d6ee-fb53-447f-a152-b77d87086688	台州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.502+08
c8c38c50-bc6d-4588-8c64-6a73ba4ff901	宁夏师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.504+08
b97e16c5-9dcc-4a91-8598-89302ec89b10	齐齐哈尔医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.508+08
442cd12b-c8aa-4ab7-998d-b29a362a2a9f	衢州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.509+08
0c0006a7-deff-48b7-81c2-82c6d60f60d9	甘肃民族师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.514+08
5096f06d-720a-4c1d-95cc-6fa195f6f40a	山东青年政治学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.516+08
6c8a90ec-5464-468f-95b7-23811f19345e	泰州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.518+08
8ee9c8ab-d3cc-4994-b7c9-2b6ef545464f	通化师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.52+08
1a568ef8-9f2e-4824-9671-8662d050d5ab	大庆师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.522+08
5e5e5f05-bdc4-443c-aee5-21fd3a161143	铜陵学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.524+08
b2ce152e-4162-412a-b6db-88b499f5f47b	湘南学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.525+08
96d4ba86-9b2a-4b23-90be-70631d5265e1	河池学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.526+08
42a16447-803e-46ec-9bf5-1651bfcadbc0	红河学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.527+08
7159ec2d-9a3c-4b84-bd3d-6c5d73bac8d3	渭南师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.528+08
c5a56473-325a-49fb-8477-9ed00b0fba14	陇东学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.53+08
943b5c36-37e3-40c2-ba53-8a96c477466f	呼伦贝尔学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.531+08
91765b1c-fed8-4951-bb91-fb362ea7493f	平顶山学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.532+08
df8a9850-4d08-4c47-b406-63c2c695f8bb	辽宁科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.533+08
03366854-b64f-4e64-8b55-3061a950cf82	吉林农业科技学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.534+08
e43d56ac-d03f-4699-9e48-8584ab183967	钦州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.535+08
708ec861-9da5-4c0a-92da-80f2f0bb94b4	辽东学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.537+08
42b59f1f-c6fb-4da7-b69c-aa023433da15	太原工业学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.538+08
36824422-ac2c-4b7c-b84e-b67aa247de16	沧州师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.539+08
a52df1f9-149f-4368-a9cd-6887ca010d25	白城师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.54+08
92eb105c-ed1c-4dfa-85b3-0fc295063daa	宁德师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.541+08
2f55d85b-a444-4a17-9ba1-97330c58e6f0	泰山学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.543+08
ed31e9a6-45df-48de-8a8b-d59aca9a4dd6	百色学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.544+08
a894a9a2-9d9e-4934-8606-6883bbc9eb71	遵义师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.962+08
0b8b8ab6-3573-4c87-a46f-4b829961e301	安顺学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.966+08
82854e00-9dbc-4202-9c28-bfebe3305fdf	新乡学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.968+08
4b4bdb46-6ef5-43f4-8930-cf6e4e793d87	湖南女子学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.976+08
cff7059d-98db-4ebd-8d4c-77490feefd05	广州航海学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.98+08
3d6fd9fc-fe3a-4698-85fc-85fb7f408c4c	武夷学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.981+08
a0461b28-6be6-4d53-b671-ce67150ab449	上饶师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.984+08
d2f266d3-434d-48ee-a830-4826c00d6813	岭南师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.988+08
1dd51698-c92b-4369-80a8-92eaa348390e	凯里学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:41.991+08
db9564dc-48d4-4be3-b82d-a80c13146703	吕梁学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.001+08
b6179b65-0993-4e5f-b897-ecdc140a61f4	营口理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.007+08
41405fa8-4403-4dbf-bf47-2c7f92681824	江苏第二师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.011+08
f8fe81c3-cbcc-4674-94b6-1575d86b02d7	重庆第二师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.023+08
25fae187-4966-4ef6-bd77-bd3ac791f8b0	保定学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.038+08
6c9a087e-459e-4b0a-aa9e-cd9c091a68d0	邯郸学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.041+08
5ec27236-ad58-4fa3-9231-b5a68fb8c284	邢台学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.046+08
a5783fcf-3532-47a5-a392-80d0c4a60130	荆楚理工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.051+08
02f24b85-cdfc-4ecc-be17-9e3d3c31442c	梧州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.054+08
d75c1a18-488b-42cc-8d4a-9f84c7432d6c	河北中医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.058+08
8cc10e92-a949-4e5e-b3c1-254f5c6e63d6	武汉商学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.062+08
39fa7189-cc20-42ed-acaf-0a7bde798f92	宿州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.064+08
b97a6d8a-f530-4e8d-bc4e-4d7b1b3507f1	济宁学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.068+08
4ea11bcd-d47d-4fda-b811-98946e37084b	周口师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.071+08
47d50c29-3663-4fb7-84c5-8b1acad34cb5	枣庄学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.072+08
e6753285-94fc-4f2b-9bc1-76b6c1468d38	新余学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.075+08
a2dbeeec-0d9a-4025-bbc8-c552e29f7518	郑州师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.077+08
292f494d-9253-49d2-93c7-ad4b1c86a76f	张家口学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.078+08
9fcae085-fee3-4ee3-b5ef-476a3f926e2b	衡水学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.084+08
2c85a21e-6bb8-44f0-ae0d-ff0c5dbc3eb6	贵阳学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.087+08
2665cbf0-233c-4ed1-9635-5f383b0801f8	池州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.091+08
83f814d2-36d5-4e4e-af91-1fc79a5f547e	榆林学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.093+08
fe348ebb-a50e-45f6-bcee-5975f9faea02	文山学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.113+08
62a84757-4ce3-4dac-9d26-afec59cc3899	山东女子学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.12+08
a2418aaa-b313-48ef-80bf-bfe227923262	山东管理学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.123+08
011484c8-1fd7-4393-8430-083b6d71a486	长沙师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.128+08
2745da36-be7f-4e03-a65e-bd8af8d63444	广西民族师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.131+08
f4dbcb9d-2210-4b60-bf6f-182dd1908567	西昌学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.135+08
12658999-b7f3-47b0-85f8-5ad5f6188e35	兴义民族师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.136+08
4d86a529-726f-4b2a-bff4-d6e8b55d0940	昆明学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.141+08
e5e70cb1-0974-49f4-8624-3afdf6232f24	贺州学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.145+08
41dc3a75-479c-4695-a3ea-e45f2463a01e	萍乡学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.15+08
5f5b9c8e-e0e2-4216-9c05-63eeb73b0e92	南昌师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.152+08
650bce58-1d96-4836-b134-fd46fe124e2b	菏泽学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.155+08
dbbf6c4a-f39a-46a5-b62f-dd0fa46eef4c	四川文理学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.16+08
caec823b-b606-4379-b984-b5a7be404e21	蚌埠学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.162+08
ae806a11-524e-45a0-b6e8-bb4d7a7ff9d9	商洛学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.167+08
605927aa-403c-4956-9ada-a2bbacf0612e	齐鲁师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.169+08
3a2f953c-37cd-4656-b024-4865b8128a43	兰州工业学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.173+08
563e21ec-75b6-436b-a5b5-41bc30a685cd	四川旅游学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.18+08
63146cce-1e6c-45c9-afc3-aae05a6d8fb8	景德镇学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.184+08
0195da55-ddbe-43e7-9189-a8d8ab43edd0	成都师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.466+08
71312a35-1ffd-4e75-8a6a-422fe5bf65fb	普洱学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.467+08
de059a55-5756-4aa8-8068-6c1b9f82b06a	铜仁学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.468+08
59f784aa-16f6-407b-8f6c-ef33f1375d40	保山学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.469+08
f3c56b76-ff4c-41bf-9654-ff9a41902e08	兰州城市学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.47+08
f9475b62-f7b1-4651-b8d4-c839dd054525	四川民族学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.47+08
df382776-9cb0-43c9-ac9a-135f8fa5ba74	陕西学前师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.471+08
5ec9ec9a-aa41-4a75-804b-eb29c1778099	首钢工学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.472+08
d72c7220-9565-4e06-a05c-96539012b4b4	河套学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.473+08
f999385c-008b-4045-a631-d42f110577a0	山东农业工程学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.474+08
e1b42f1e-ccc6-4b77-b3f4-6ab4408198c9	六盘水师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.475+08
768f62be-59e6-4a0e-b3df-a7eea4337249	南京特殊教育师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.476+08
4f2af15e-10d8-4e2f-bcd2-1cc97d3ca7cc	上海健康医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.477+08
023fba34-c156-43c3-ba08-634b91e38c2c	阿坝师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.478+08
a0a68a4f-931b-4ede-a319-f74d98d457f9	桂林旅游学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.478+08
0aac000b-2105-4c98-a6b5-6a9d16db085b	贵州工程应用技术学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.479+08
a6cb80cf-d7c4-438a-b92a-bdbe443cb726	甘肃医学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.48+08
1af47f48-3fcf-46b6-bcc7-fb246035676d	湖南医药学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.481+08
c2b98b39-48f4-4f98-9098-304e7a7caea9	滇西科技师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.482+08
6b97cae3-a3f4-4a11-8b85-4849f5db4913	呼和浩特民族学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.483+08
f95649da-e444-4bcb-96d7-5c29eb466657	昭通学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.485+08
de5cb309-c74a-4879-b42e-e20626a1c35b	广西科技师范学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.486+08
9bfdf758-2968-4915-93ef-438858d49ecd	贵州商学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.487+08
348a06a7-fc99-42ff-bce1-87c6b93b2a51	山西工程技术学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.488+08
26b353da-eaee-452a-ba38-d34b13ee0d06	鄂尔多斯应用技术学院	10000000-3c59-4887-995b-cf275db86343	f	f	\N	0	chinese-college	\N	f	english	2016-08-25 16:55:42.489+08
\.


--
-- Name: channels_name_key; Type: CONSTRAINT; Schema: public; Owner: tienson
--

ALTER TABLE ONLY channels
    ADD CONSTRAINT channels_name_key UNIQUE (name);


--
-- Name: channels_pkey; Type: CONSTRAINT; Schema: public; Owner: tienson
--

ALTER TABLE ONLY channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

