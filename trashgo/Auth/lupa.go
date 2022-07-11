package Auth

import (
	"trashgo/Database"
	"trashgo/Models"

	"golang.org/x/crypto/bcrypt"

	"github.com/dgrijalva/jwt-go"
	"github.com/gofiber/fiber/v2"
)

func Reset(c *fiber.Ctx) error {
	var data map[string]string

	if err := c.BodyParser(&data); err != nil {
		return err
	}

	var user Models.User
	if data["password"] != data["ppassword_confim"] {
		return c.Status(400).JSON(fiber.Map{
			"message": "Salah",
		})
	}

	cookie := c.Cookies("jwt")

	token, err := jwt.ParseWithClaims(cookie, &jwt.StandardClaims{}, func(token *jwt.Token) (interface{}, error) {
		return []byte(SecretKey), nil
	})
	if err != nil {
		c.Status(fiber.StatusUnauthorized)
		return c.JSON(fiber.Map{
			"message": "gagal terhubung",
		})
	}
	password, _ := bcrypt.GenerateFromPassword([]byte(data["password"]), bcrypt.DefaultCost)
	claims := token.Claims.(*jwt.StandardClaims)
	Database.DB.Model(&user).Where("Id_user = ?", claims.Issuer).Updates(Models.User{Password: password})

	return c.JSON(fiber.Map{
		"Massage":"Password telah di ganti",
	})
}
