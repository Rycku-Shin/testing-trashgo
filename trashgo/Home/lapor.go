package Home

import (
	"trashgo/Database"
	"trashgo/Models"

	"github.com/gofiber/fiber/v2"
)

func Laporan(c *fiber.Ctx) error {
	var data map[string]string
	var dataint map[string]int
	if err := c.BodyParser(&data); err != nil {
		return err
	}
	if err := c.BodyParser(&dataint); err!= nil{
		return err
	}

	laporan := Models.Laporan{

		Data_laporan: data["data_laporan"],
		Id_komplek:   dataint["id_komplek"],
		Id_kota: dataint["id_kota"],
	}

	Database.DB.Create(&laporan)

	return c.JSON(fiber.Map{
		"message": "Terima Kasih laporan anda akan di proses ",
	})
}