package Home

import (
	"fmt"
	"log"
	"strings"
	"trashgo/Models"
	"trashgo/Database"

	"github.com/gofiber/fiber/v2"
	"github.com/google/uuid"
)

func Fileupload(c *fiber.Ctx) error {

	// parse incomming image file

	file, err := c.FormFile("gambar")

	if err != nil {
		log.Println("image upload error --> ", err)
		return c.JSON(fiber.Map{"status": 500, "message": "Server error", "data": nil})

	}

	// generate new uuid for image name
	uniqueId := uuid.New()

	// remove "- from imageName"

	filename := strings.Replace(uniqueId.String(), "-", "", -1)

	// extract image extension from original file filename

	fileExt := strings.Split(file.Filename, ".")[1]

	// generate image from filename and extension
	image := fmt.Sprintf("%s.%s", filename, fileExt)

	// save image to ./images dir
	err = c.SaveFile(file, fmt.Sprintf("C:/Users/bagja/go/src/trashgo/Home/gambar/%s", image))

	if err != nil {
		log.Println("image save error --> ", err)
		return c.JSON(fiber.Map{"status": 500, "message": "Server error", "data": nil})
	}

	// generate image url to serve to client using CDN

	imageUrl := fmt.Sprintf("http://localhost:1234/image/%s", image)

	// create meta data and send to client

	laps := Models.Laporan{
		Data_laporan: imageUrl,
	}
	Database.DB.Create(&laps)
	return c.JSON(laps)
}
