package router

import (
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func NewRouter() *chi.Mux {
	r := chi.NewRouter()

	// Middleware
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)
	r.Use(middleware.RequestID)
	r.Use(middleware.RealIP)

	// Static files
	fileServer := http.FileServer(http.Dir("./public"))
	r.Handle("/public/*", http.StripPrefix("/public/", fileServer))

	// Template files
	templateServer := http.FileServer(http.Dir("./template"))
	r.Handle("/template/*", http.StripPrefix("/template/", templateServer))

	// API Routes
	r.Route("/api", func(r chi.Router) {
		// Profile routes
		r.Route("/profile", func(r chi.Router) {
			r.Get("/", nil)      // handler.GetProfile
			r.Put("/", nil)      // handler.UpdateProfile
		})

		// Social Media routes
		r.Route("/social-media", func(r chi.Router) {
			r.Get("/", nil)      // handler.GetAllSocialMedia
			r.Post("/", nil)     // handler.CreateSocialMedia
			r.Put("/{id}", nil)  // handler.UpdateSocialMedia
			r.Delete("/{id}", nil) // handler.DeleteSocialMedia
		})

		// Education routes
		r.Route("/education", func(r chi.Router) {
			r.Get("/", nil)      // handler.GetAllEducation
			r.Post("/", nil)     // handler.CreateEducation
			r.Get("/{id}", nil)  // handler.GetEducationByID
			r.Put("/{id}", nil)  // handler.UpdateEducation
			r.Delete("/{id}", nil) // handler.DeleteEducation
		})

		// Experience routes
		r.Route("/experiences", func(r chi.Router) {
			r.Get("/", nil)      // handler.GetAllExperiences
			r.Post("/", nil)     // handler.CreateExperience
			r.Get("/{id}", nil)  // handler.GetExperienceByID
			r.Put("/{id}", nil)  // handler.UpdateExperience
			r.Delete("/{id}", nil) // handler.DeleteExperience
		})

		// Skills routes
		r.Route("/skills", func(r chi.Router) {
			r.Get("/", nil)      // handler.GetAllSkills
			r.Post("/", nil)     // handler.CreateSkill
			r.Put("/{id}", nil)  // handler.UpdateSkill
			r.Delete("/{id}", nil) // handler.DeleteSkill
		})

		// Services routes
		r.Route("/services", func(r chi.Router) {
			r.Get("/", nil)      // handler.GetAllServices
			r.Post("/", nil)     // handler.CreateService
			r.Get("/{id}", nil)  // handler.GetServiceByID
			r.Put("/{id}", nil)  // handler.UpdateService
			r.Delete("/{id}", nil) // handler.DeleteService
		})

		// Projects routes
		r.Route("/projects", func(r chi.Router) {
			r.Get("/", nil)      // handler.GetAllProjects
			r.Post("/", nil)     // handler.CreateProject
			r.Get("/{id}", nil)  // handler.GetProjectByID
			r.Put("/{id}", nil)  // handler.UpdateProject
			r.Delete("/{id}", nil) // handler.DeleteProject
			r.Get("/featured", nil) // handler.GetFeaturedProjects
		})

		// Project Images routes
		r.Route("/project-images", func(r chi.Router) {
			r.Post("/", nil)     // handler.CreateProjectImage
			r.Get("/project/{projectId}", nil) // handler.GetProjectImages
			r.Delete("/{id}", nil) // handler.DeleteProjectImage
		})

		// Testimonials routes
		r.Route("/testimonials", func(r chi.Router) {
			r.Get("/", nil)      // handler.GetAllTestimonials
			r.Post("/", nil)     // handler.CreateTestimonial
			r.Put("/{id}", nil)  // handler.UpdateTestimonial
			r.Delete("/{id}", nil) // handler.DeleteTestimonial
			r.Put("/{id}/approve", nil) // handler.ApproveTestimonial
		})

		// Blog Posts routes
		r.Route("/blog", func(r chi.Router) {
			r.Get("/", nil)      // handler.GetAllBlogPosts
			r.Post("/", nil)     // handler.CreateBlogPost
			r.Get("/{slug}", nil) // handler.GetBlogPostBySlug
			r.Put("/{id}", nil)  // handler.UpdateBlogPost
			r.Delete("/{id}", nil) // handler.DeleteBlogPost
			r.Put("/{id}/publish", nil) // handler.PublishBlogPost
		})

		// Blog Comments routes
		r.Route("/comments", func(r chi.Router) {
			r.Get("/post/{postId}", nil) // handler.GetCommentsByPost
			r.Post("/", nil)     // handler.CreateComment
			r.Delete("/{id}", nil) // handler.DeleteComment
			r.Put("/{id}/approve", nil) // handler.ApproveComment
		})

		// Contact Messages routes
		r.Route("/contact", func(r chi.Router) {
			r.Post("/", nil)     // handler.CreateContactMessage
			r.Get("/", nil)      // handler.GetAllContactMessages
			r.Get("/{id}", nil)  // handler.GetContactMessageByID
			r.Put("/{id}/read", nil) // handler.MarkAsRead
			r.Put("/{id}/reply", nil) // handler.MarkAsReplied
			r.Delete("/{id}", nil) // handler.DeleteContactMessage
		})
	})

	// Web Routes (untuk render HTML template)
	r.Get("/", nil)          // handler.IndexPage
	r.Get("/about", nil)     // handler.AboutPage
	r.Get("/services", nil)  // handler.ServicesPage
	r.Get("/portfolio", nil) // handler.PortfolioPage
	r.Get("/portfolio/{id}", nil) // handler.PortfolioDetailPage
	r.Get("/blog", nil)      // handler.BlogPage
	r.Get("/blog/{slug}", nil) // handler.SingleBlogPage
	r.Get("/contact", nil)   // handler.ContactPage

	return r
}
