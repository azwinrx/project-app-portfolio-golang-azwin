package router

import (
	"project-app-portfolio-golang-azwin/handler"
	"project-app-portfolio-golang-azwin/service"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"go.uber.org/zap"
)


func NewRouter(svc *service.Service, handl *handler.Handler, log *zap.Logger) *chi.Mux {
	r := chi.NewRouter()


	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	// root
	r.Get("/", handl.HomeHandler.HomepageView)

	// Download
	r.Route("/download", func(r chi.Router) {
		r.Get("/cv", handl.DownloadHandler.DownloadCV)
		r.Get("/cv-detail", handl.DownloadHandler.SeeCV)

	})

	r.Get("/about", handl.AboutHandler.AboutpageView)
	r.Get("/portfolio", handl.PortofolioHandler.PortofolioPageView)
	r.Route("/contact", func(r chi.Router) {
		r.Get("/", handl.ContactHandler.ContactPageView)
		r.Post("/send", handl.ContactHandler.SendMessageHandler)
	})

	return r
}