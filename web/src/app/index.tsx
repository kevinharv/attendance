import DashboardCard from "@/components/DashboardCard";
import { Card, Container, Stack } from "@mui/material";
import { createFileRoute } from "@tanstack/react-router";

export const Route = createFileRoute("/")({
  component: Dashboard,
});
function Dashboard() {
  return (
    <Container maxWidth={"xl"}>
      <Stack direction={"row"} spacing={2} useFlexGap sx={{ flexWrap: "wrap" }}>
        <DashboardCard>
          <p>Foo bar ipsum selenium forbuster for the end of the earth</p>
          <p>what about me</p>
        </DashboardCard>
      </Stack>
    </Container>
  );
}
