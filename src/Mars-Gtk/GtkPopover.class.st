"
GtkPopover
GtkPopover — Context dependent bubbles

https://developer.gnome.org/gtk3/stable/GtkPopover.html
"
Class {
	#name : #GtkPopover,
	#superclass : #GtkBin,
	#category : #'Mars-Gtk-Widget-Toolbar'
}

{ #category : #accessing }
GtkPopover class >> gType [ 
	"This method was automatically generated"

	^ self ffiCall: #(gsize gtk_popover_get_type())
]

{ #category : #'instance creation' }
GtkPopover class >> new [

	^ self newRelativeTo: GtkWidget null
]

{ #category : #'instance creation' }
GtkPopover class >> newRelativeTo: aWidget [

	^ (self popoverNewRelativeTo: aWidget) initialize
]

{ #category : #private }
GtkPopover class >> popoverNewRelativeTo: aWidget [

	^ self ffiCall: #(GtkPopover *gtk_popover_new (GtkWidget *aWidget))
]

{ #category : #accessing }
GtkPopover >> beModal [

	self modal: true
]

{ #category : #accessing }
GtkPopover >> beRelativeTo: aWidget [

	^ self ffiCall: #(void gtk_popover_set_relative_to (self, GtkWidget *aWidget))
]

{ #category : #accessing }
GtkPopover >> defaultWidget [

	^ self ffiCall: #(GtkWidget *gtk_popover_get_default_widget (self))
]

{ #category : #accessing }
GtkPopover >> defaultWidget: aWidget [

	^ self ffiCall: #(void gtk_popover_set_default_widget (self, GtkWidget *aWidget))
]

{ #category : #testing }
GtkPopover >> isModal [

	^ self ffiCall: #(gboolean gtk_popover_get_modal (self))
]

{ #category : #private }
GtkPopover >> modal: modal [

	^ self ffiCall: #(void gtk_popover_set_modal (self, gboolean modal))
]

{ #category : #accessing }
GtkPopover >> pointingTo: aRect [

	self setPointingTo: aRect asGdkRectangle
]

{ #category : #accessing }
GtkPopover >> popdown [

	^ self ffiCall: #(void gtk_popover_popdown (self))
]

{ #category : #accessing }
GtkPopover >> popup [

	^ self ffiCall: #(void gtk_popover_popup (self))
]

{ #category : #accessing }
GtkPopover >> preferredPosition [

	^ self ffiCall: #(GtkPositionType gtk_popover_get_position (self))
]

{ #category : #accessing }
GtkPopover >> preferredPosition: aPosition [

	^ self ffiCall: #(void gtk_popover_set_position (self, GtkPositionType position))
]

{ #category : #accessing }
GtkPopover >> relativeWidget [

	^ self ffiCall: #(GtkWidget *gtk_popover_get_relative_to (self))
]

{ #category : #private }
GtkPopover >> setPointingTo: rect [

	^ self ffiCall: #(void gtk_popover_set_pointing_to (self, const GdkRectangle *rect))
]
