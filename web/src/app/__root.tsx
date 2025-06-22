import { Outlet, createRootRoute } from "@tanstack/react-router";
import { TanStackRouterDevtools } from "@tanstack/react-router-devtools";
import NavigationDrawer from "@/components/NavigationDrawer";

export const Route = createRootRoute({
  component: () => (
    <>
      <NavigationDrawer>
        <Outlet />
      </NavigationDrawer>
      {/* <TanStackRouterDevtools /> */}
    </>
  ),
});

/*

  ROOT
  - navbar (tabs down the side)
  - minimal top bar? maybe none at all?


  /dashboard
    - daily attendance (#/%)
    - # of courses, sections
    - min/max attendance (# & %)
  /people
    - students
    - instructors
  /courses
    /{id}
      /
      /sections
  /schools
  /admin
  /reports
  /attend

*/
