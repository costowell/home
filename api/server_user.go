package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// Users handles /api/v1/users
func (APIServer) Users(ctx *gin.Context) {
	userID := UserID("test")
	resp := []User{
		{
			UserId: &userID,
		},
	}
	ctx.JSON(http.StatusOK, resp)
}
