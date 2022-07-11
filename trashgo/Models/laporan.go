package Models

import (
	"time"
)

type Laporan struct {
	Id_laporan             int
	Data_laporan           string`json:"imageUrl"`
	Id_komplek             int
	Id_kendaraan           int
	Id_supir               int
	Status_laporan_user    bool
	Status_laporan_komplek bool
	Id_kota                int
	Id_jalur               int
	tgl_laporan            time.Time
}
type Laps struct {
	ImageURL string `json:"imageUrl"`
}
