package dto

// ContactRequest DTO untuk request contact form
type ContactRequest struct {
	Name    string `json:"name" validate:"required,min=2,max=100"`
	Email   string `json:"email" validate:"required,email"`
	Subject string `json:"subject,omitempty" validate:"max=200"`
	Message string `json:"message" validate:"required,min=10,max=1000"`
	Phone   string `json:"phone,omitempty" validate:"max=20"`
}

// ContactResponse DTO untuk response contact message
type ContactResponse struct {
	ID        int    `json:"id"`
	Name      string `json:"name"`
	Email     string `json:"email"`
	Subject   string `json:"subject,omitempty"`
	Message   string `json:"message"`
	Phone     string `json:"phone,omitempty"`
	IsRead    bool   `json:"is_read"`
	IsReplied bool   `json:"is_replied"`
	CreatedAt string `json:"created_at"`
}

// ContactListResponse DTO untuk list contact messages (admin)
type ContactListResponse struct {
	Messages []ContactResponse `json:"messages"`
	Total    int               `json:"total"`
}

// ToContactResponse method untuk convert model ke DTO
func (c *ContactRequest) ToContactResponse(id int, isRead, isReplied bool, createdAt string) ContactResponse {
	return ContactResponse{
		ID:        id,
		Name:      c.Name,
		Email:     c.Email,
		Subject:   c.Subject,
		Message:   c.Message,
		Phone:     c.Phone,
		IsRead:    isRead,
		IsReplied: isReplied,
		CreatedAt: createdAt,
	}
}