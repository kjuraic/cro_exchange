library(data.table)


read_tecaj_hnb <- function(hnb_url = "http://www.hnb.hr/hnb-tecajna-lista-portlet/rest/tecajn/getformatedrecords.dat"){
  header <- scan(file = hnb_url, what = character(), nlines = 1)
  tecaj_br <- as.numeric(substr(header, start = 1, stop = 3))
  tecaj_datum_izrada <- as.Date(x = substr(header, start = 4, stop = 11), format = "%d%m%Y")
  tecaj_datum_primjena <- as.Date(x = substr(header, start = 12, stop = 19), format = "%d%m%Y")
  br_slogova <- tecaj_datum_izrada <- as.numeric(substr(header, start = 20, stop = 21))
  tbl <- fread(input = hnb_url, skip = 1, sep = " ", header = FALSE, nrows = br_slogova)
  kupovni <- scan(text = tbl$V2, dec = ',')
  srednji <- scan(text = tbl$V3, dec = ',')
  prodajni <- scan(text = tbl$V4, dec = ',')
  sifra <- as.numeric(substr(x = tbl$V1, start = 1, stop = 3))
  oznaka <- as.character(substr(x = tbl$V1, start = 4, stop = 6))
  jedinica <- as.numeric(substr(x = tbl$V1, start = 7, stop = 9))
  tecaj_tbl <- data.frame(oznaka, sifra, jedinica, kupovni, srednji, prodajni)
  tecaj_lst <- list(tecaj_br = tecaj_br, datum_izrada = tecaj_datum_izrada, datum_primjena = tecaj_datum_primjena, tecaj = tecaj_tbl)  
  return(tecaj_lst)
}

hrk_2_valuta <- function(iznos, oznaka = "EUR", tip = "srednji", tecaj){
  redak <- subset(tecaj, oznaka == valuta)
  faktor <- as.numeric(redak[tip])
  jedinica <- as.numeric(redak["jedinica"])
  iznos2 <- iznos / faktor * jedinica
  return(iznos2)
}

valuta_2_hrk <- function(iznos, oznaka = "EUR", tip = "srednji", tecaj){
  redak <- subset(tecaj, oznaka == valuta)
  faktor <- as.numeric(redak[tip])
  jedinica <- as.numeric(redak["jedinica"])
  iznos2 <- iznos * faktor / jedinica
  return(iznos2)
}


iznos <- 1
tip <- "srednji"
valuta <- "EUR"
dat <- read_tecaj_hnb()
tecaj <- dat$tecaj
hrk_2_valuta(1, tecaj = tecaj)
