import { createFileRoute } from '@tanstack/react-router'

export const Route = createFileRoute("/about")({
  component: About,
})

function About() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>ABOUT</h1>
      </header>
    </div>
  )
}
